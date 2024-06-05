import {
  onDocumentCreated,
  onDocumentDeleted,
} from "firebase-functions/v2/firestore";

// import {
//   onObjectFinalized,
// } from "firebase-functions/v2/storage";

import * as admin from 'firebase-admin'
import { TokenMessage } from "firebase-admin/lib/messaging/messaging-api";

/*
import {
  QueryDocumentSnapshot,
} from "firebase-admin/firestore";*/

const { initializeApp } = require('firebase-admin/app');
const { getFirestore, FieldValue, Timestamp } = require('firebase-admin/firestore');
const { getStorage, getDownloadURL } = require("firebase-admin/storage");
const { onSchedule } = require("firebase-functions/v2/scheduler");
const { logger } = require("firebase-functions");
const functions = require("firebase-functions");

initializeApp();
const db = getFirestore();
const storage = getStorage();

exports.deleteCalendarImage = onDocumentDeleted("calendar/{calendarId}", (calendar)=> {
  try{
    const calendarId = calendar.params.calendarId;
    const snapshot = calendar.data;
    logger.log(snapshot)
    if(!snapshot){
      console.log("No data associated with the event")
      return;
    }
    const data = snapshot.data()
    const fileName = data.fileName
    logger.log(fileName)
    if(fileName != null){
      deleteImage(calendarId, fileName)
    }
  }catch (e){
    console.log(e)
  }
});


exports.updateCalendarImage = functions.region("asia-northeast1").storage.object().onFinalize(async (object: { bucket: any; name: any; contentType: any; }) => {
  const fileBucket = object.bucket; // Storage bucket containing the file.
  const filePath = object.name; // File path in the bucket.
  const bucket = storage.bucket(fileBucket);
  
  const path:string[] = filePath.split('/');
  if(path.length != 4){
    console.log('The location where the image was created is incorrect');
    return;
  }

  const calendarId = path[2]
  const fileName = path[3]

  const downloadUrl = await getDownloadURL(bucket.file(filePath));
  logger.log(downloadUrl);

  const snapshots = await db.collection('calendar').doc(calendarId).get()
  const data = snapshots.data()

  logger.log(data)
  if(data != null){
    const previousFileName = data.fileName
    if(previousFileName != null){
      const deleteResult = await deleteImage(calendarId, previousFileName)
      if(deleteResult != null) return;
      updateCalendarDoc(calendarId, downloadUrl, fileName)
    }else{
      updateCalendarDoc(calendarId, downloadUrl, fileName)
    }
  }else{
    console.log('No data');
    return;
  }
  
});

async function deleteImage(calendarId: string, fileName: string){
  try{
    const bucket = storage.bucket();
    const file = bucket.file("images/calendar/" + calendarId + "/" + fileName);
    await file.delete();
    console.log('Delete Image: '+ calendarId + "/" + fileName);
    return null
  }catch(e){
    console.log('cannot delete image')
    return e;
  }
}

async function updateCalendarDoc(calendarId: string, url: string, fileName: string){
  try{
    await db.doc("calendar/" + calendarId).update({ image: url, fileName: fileName });
    console.log('Update calendar: '+ calendarId);
    return null
  }catch(e){
    console.log('cannot update calendar document')
    return e;
  }
}

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
    const snapshots = await db.collectionGroup('event').where('notificationExist','==', true).where('from', '==', now).get()
    if(!snapshots.empty){
      const events = snapshots.docs.map((doc: { data: () => any; id: string; }) => {
        const data = doc.data()
        const id = doc.id
        return new Event(id, data.calendarId, data.uid, data.title)
      })
      for(const event of events){
        const messages = await getSenderEventNotification(event)
        logger.log(messages)
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
        const tokens = await getUserToken(uid)
        if(!tokens.empty){
          for(const token of tokens){
            const megs = sendPushNotificationsForReminder(event,token)
            message.push(megs)
          }
        }
      }
    }else{
      const tokens = await getUserToken(event.uid)
      if(!tokens.empty){
        for(const token of tokens){
          const megs = sendPushNotificationsForReminder(event,token)
          message.push(megs)
        }
      }
    }

    return message
  }catch(err){
    console.log(err)
    return message
  }
}

async function getUserToken(uid: string){
  try{
    const snapshots = await db.collection('user').where('uid', '==', uid).get()
    if(snapshots != null){
      const tokens = snapshots.docs.map((doc: { data: () => any;}) => doc.data().token)
      return tokens
    }
    
  }catch (e){
    throw e
  }
}


function sendPushNotificationsForReminder(event: Event, token: string) {
  const notification: admin.messaging.Notification = {
    title: event.title,
  }
  const data: admin.messaging.DataMessagePayload = {
    calendarId: String(event.calendarId),
    eventId: String(event.eventId)
  }
  const message: admin.messaging.Message = {
    token: token,
    data: data,
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

  logger.log(msgs)
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
