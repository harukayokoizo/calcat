import {
  onDocumentCreated,
  onDocumentDeleted,
} from "firebase-functions/v2/firestore";

const { initializeApp } = require('firebase-admin/app');
const { getFirestore, FieldValue } = require('firebase-admin/firestore');
const { onSchedule } = require("firebase-functions/v2/scheduler");
const { logger } = require("firebase-functions");

initializeApp();
const db = getFirestore();

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

exports.scheduledEventNotification = onSchedule("* * * * *", async () => {
  logger.log('Hello');
  // 現在時刻を取得
  const now = (() => {
    let s = db.Timestamp.now().seconds
    s = s - s % 60
    return new db.Timestamp(s, 0)
  })()

  try{
    const snapshots = await db.collectionGroup('event').where('from', '==', now).where('notificationExists', true).get()
    snapshots.docs.map((doc: any) =>{
      if(doc.empty){
        logger.log('No matching documents')
        return;
      }
      console.log(doc)
      // await getSenderEventNotification(doc.id(), doc.data)
    })
  }catch(e){
    console.log(e)
  }
  // 取得したドキュメントの通知サブコレクションのドキュメントを全部取得
  // 各ドキュメントのuserReferenceの値からUserコレクションのドキュメントを取得（トークンを取得）
  // 通知する。
});

/*
async function getSenderEventNotification(String: any docId: any, dynamic: undefined doc: { calendarId: any; } | undefined){
  try{
    const calendarId = doc.calendarId;
    if(calendarId != null){
      const notificationList = await db.collection('calendar').doc(calendarId).collection('event').doc(eventId).collection('notification').get()
    }else{
      const notificationList = await db.collection('event').doc(eventId).collection('notification').get()
    }
  }catch(err){
    console.log(err)
  }
  
}

async function sendPushNotificationsForReminder(reminders: Model.Reminder[]) {
  const messages: admin.messaging.Message[] = []
  for (const reminder of reminders) {
    // ユーザーのトークンは複数ある可能性があるので、ユーザーのトークン分メッセージを作る
    const msgs: admin.messaging.Message[] = reminder.tokens.map((token: any) => {
      const notification: admin.messaging.Notification = {
        title: "リマインダー",
        body: reminder.task.content
      }
      const message: admin.messaging.Message = {
        token: token,
        notification: notification
      }
      return message
    })
    Array.prototype.push.apply(messages, msgs)
  }
  if (messages.length === 0) { return }
  await sendAll(messages)
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
      .sendAll(ms)
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
}*/
