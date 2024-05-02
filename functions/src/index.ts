import {
  onDocumentCreated,
  onDocumentDeleted,
} from "firebase-functions/v2/firestore";

import * as admin from 'firebase-admin'
import { TokenMessage } from "firebase-admin/lib/messaging/messaging-api";

/*
import {
  QueryDocumentSnapshot,
} from "firebase-admin/firestore";*/

const { initializeApp } = require('firebase-admin/app');
const { getFirestore, FieldValue, Timestamp } = require('firebase-admin/firestore');
const { getStorage } = require("firebase-admin/storage");
const { onSchedule } = require("firebase-functions/v2/scheduler");
const { logger } = require("firebase-functions");

initializeApp();
const db = getFirestore();
const storage = getStorage();

exports.deleteCalendarImage = onDocumentDeleted("calendar/{calendarId}", (calendar)=> {
  try{
    const calendarId = event.params.calendarId;
    const defaultBucket = storage.bucket();
    const file = defaultBucket.file("images/calendar/" + calendarId);

    return file.delete();
  }catch (e){
    console.log(e)
  }
});

exports.incrementFollow = onDocumentCreated("calendar/{calendarId}/calendar_user/{userId}", (event)=> {
  try{
    const calendarId = event.params.calendarId;
    db.doc("calendar/" + calendarId).update({ followsCount: FieldValue.increment(1.0) });
  }catch (e){
    console.log(e)
  }
});

exports.decrementFollow = onDocumentDeleted("calendar/{calendarId}/calendar_user/{userId}", (event) => {
  try{
    const calendarId = event.params.calendarId;
    db.doc("calendar/" + calendarId).update({ followsCount: FieldValue.increment(-1.0) });
  }catch (e){
    console.log(e)
  }
});

exports.notificationExitsTrue = onDocumentCreated("calendar/{calendarId}/event/{eventId}/notification/{notificationId}", async (notification) => {
  try{
    const calendarId = notification.params.calendarId
    const eventId = notification.params.eventId
    const snapshot = await db.collection('calendar').doc(calendarId).collection('event').doc(eventId).get()
    const event = snapshot.data()
    if(!event.notificationExits){
      db.collection('calendar').doc(calendarId).collection('event').doc(eventId).update({ notificationExist: true });
    }
  }catch (e){
    console.log(e)
  }
});

exports.notificationExitsFalse = onDocumentDeleted("calendar/{calendarId}/event/{eventId}/notification/{notificationId}", async (notification) => {
  try{
    const calendarId = notification.params.calendarId
    const eventId = notification.params.eventId
    const snapshot = await db.collection('calendar').doc(calendarId).collection('event').doc(eventId).collection('notification').limit(1).get()
    if(snapshot.empty){
      db.collection('calendar').doc(calendarId).collection('event').doc(eventId).update({ notificationExist: false });
    }
  }catch (e){
    console.log(e)
  }
});

class Event{
  constructor(
    readonly eventId: string, 
    readonly calendarId: string, 
    readonly uid: string, 
    readonly title: string) {}
}

exports.scheduledEventNotification = onSchedule("* * * * *", async () => {
  logger.log('Hello')
  const now = (() => {
    let s = Timestamp.now().seconds
    s = s - s % 60
    return new Timestamp(s, 0)
  })()

  try{
    const snapshots = await db.collectionGroup('event').where('notificationExist','==', true).where('from', '!=', now).get()
    if(!snapshots.empty){
      const events = snapshots.docs.map((doc: { data: () => any; id: string; }) => {
        const data = doc.data()
        const id = doc.id
        return new Event(id, data.calendarId, data.uid, data.title)
      })
      for(const event of events){
        const messages = await getSenderEventNotification(event)
        if(messages.length !== 0){
          await sendAll(messages)
        }
      }
    }
  }catch(e){
    logger.log(e)
  }
});


async function getSenderEventNotification(event: Event){
  const message: TokenMessage[] = []
  try{
    if(event.calendarId != null){
      const snapshots = await db.collection('calendar').doc(event.calendarId).collection('event').doc(event.eventId).collection('notification').get()
      if(snapshots.empty) return message
      const uidList = snapshots.docs.map((doc: { id: string; }) => doc.id)
      for(const uid of uidList){
        const token = await getUserToken(uid)
        if(token != null){
          const megs = sendPushNotificationsForReminder(event,token)
          message.push(megs)
        }
      }
    }else{
      const token = await getUserToken(event.uid)
      if(token != null){
        const megs = sendPushNotificationsForReminder(event,token)
        message.push(megs)
      }
    }

    return message
  }catch(err){
    console.log(err)
    return message
  }
}

async function getUserToken(uid: string){
  const snapshots = await db.collection('user').doc(uid).get()
  const data = snapshots.data()
  return data.token
}


function sendPushNotificationsForReminder(event: Event, token: string) {
  const notification: admin.messaging.Notification = {
    title: event.title,
  }
  const message: admin.messaging.Message = {
    token: token,
    notification: notification
  }

  return message
}

async function sendAll(messages: admin.messaging.Message[]) {
  // 500件ずつに分割する(500件以上は、sendAllメソッド側でエラーになるため)
  const msgs = messages.reduce((acc: admin.messaging.Message[][], val) => {
    const MAX_BATCH_SIZE = 500
    const last = acc[acc.length - 1]
    if (last.length === MAX_BATCH_SIZE) {
      acc.push([val])
      return acc
    }
    last.push(val)
    return acc
  }, [[]])

  // Promise.allで分割して配信
  const promises = msgs
    .map((ms) => admin.messaging()
      .sendEach(ms)
      .then((batchResponse: { responses: any[]; }) => {
        batchResponse.responses.forEach((res: { error: any; }) => {
          // FCM側でエラーが発生した場合、StackDriverにログを残す
          if (res.error) {
            console.error(res.error)
          }
        })
        console.log(`send messages: ${ms.length} count`)
      })
      .catch((e: any) => {
        console.error(e)
      })
    )
  await Promise.all(promises)
}
