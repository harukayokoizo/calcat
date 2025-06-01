import {
  onDocumentCreated,
  onDocumentDeleted,
} from "firebase-functions/v2/firestore";

// import {
//   onObjectFinalized,
// } from "firebase-functions/v2/storage";

import * as admin from 'firebase-admin'
import { TokenMessage } from "firebase-admin/lib/messaging/messaging-api";
import * as nodemailer from 'nodemailer';


/*
import {
  QueryDocumentSnapshot,
} from "firebase-admin/firestore";*/

const { initializeApp } = require('firebase-admin/app');
const { getFirestore, FieldValue, Timestamp } = require('firebase-admin/firestore');
const { getStorage, getDownloadURL } = require("firebase-admin/storage");
const { getAuth } = require("firebase-admin/auth");
const { onSchedule } = require("firebase-functions/v2/scheduler");
const { onRequest } = require("firebase-functions/v2/https");
const { logger } = require("firebase-functions");
const functions = require("firebase-functions");

initializeApp();
const db = getFirestore();
const storage = getStorage();
const auth = getAuth();

exports.sendAuthenticationMail = onRequest({timeoutSeconds: 60}, async (req: { body: any;}, res: any) => {
  try{
    //ActionCodeSettings
    const acs = {
      url: 'https://sharecalendar.page.link',
      // This must be true for email link sign-in.
      handleCodeInApp: true,
      iOS: {
        bundleId: 'com.harukayokomizo.banana-sharecalendar',
      },
      // FDL custom domain.
      dynamicLinkDomain: 'sharecalendar.page.link',
    };
    //メールを送信
    const userEmail = req.body.data;
    const transporter = nodemailer.createTransport({
      host: 'smtp.zeptomail.jp',
      port: 465,
      secure: true,
      auth: {
        user: 'emailapikey',
        pass: 'BKhVP7BB9UYS8zzbcpmArUZzD084OTQjKC5q+K1HaPqDW0K2l2SUlwWjTrGEDRBvmaKgZIgZAaXZGLFaTAxNjbdHs9waq8v8grAybVg2AM2hVBc7e75XibuxTZufPrs0KjwOutY8z8wT/Q=='
      }
    });
    const link = await auth.generateSignInWithEmailLink(userEmail, acs);

    const mailOptions = {
      from: 'info@getcalcat.com',
      to: userEmail,
      subject: '【CalCat】ログイン用リンクのご案内',
      html: `
        <p>${userEmail} 様</p>
        <p>CalCatへのログインをご希望いただきありがとうございます。</p>
        <p>以下のリンクをクリックしてログインを完了してください。</p>
        <p><a href="${link}">▶ ログインリンクはこちら</a></p>
        <p>※このリンクは一定時間で無効になります。お早めにアクセスしてください。</p>
        <hr>
        <p>このメールに心当たりがない場合は、リンクをクリックせず削除してください。</p>
        <br>
        <p>今後ともCalCatをよろしくお願いいたします。</p>
        <p style="color:gray;">CalCat サポートチーム</p>
      `
    };

    transporter.sendMail(mailOptions)
    .then((info) => {
      return res.status(200).send('success');
    })
    .catch((error) => {
      console.log(error)
      return res.status(500).send(error);
    });

  }catch (e){
    console.log(e);
    return res.status(500).send('error');
  }
});

exports.deleteCalendar = onDocumentDeleted("calendar/{calendarId}", async (calendar)=> {
  try{
    const calendarId = calendar.params.calendarId;
    const snapshot = calendar.data;
    if(snapshot == null){
      console.log("No data associated with the calendar")
      return;
    }
    const path = snapshot.ref.path;
    const docRef = db.doc(path);
    await db.recursiveDelete(docRef);

    const data = snapshot.data()
    const fileName = data.fileName
    logger.log(fileName)
    if(fileName != null){
      await deleteImage(calendarId, fileName)
    }
  }catch (e){
    console.log(e)
  }
});

exports.deleteUser = onDocumentDeleted("user/{uid}", async (user)=> {
  try{
    const uid = user.params.uid;
    
    const token = await db.collection('token').where('uid','==', uid).get()
    token.docs.map(async (doc: {ref: any;}) => {
      await doc.ref.delete()
    })

    const event = await db.collection('event').where('uid','==', uid).get()
    event.docs.map(async (doc: {ref: any;}) => {
      await doc.ref.delete()
    })

    const calendar = await db.collection('calendar').where('author','==', uid).get()
    calendar.docs.map(async (doc: {ref: any;}) => {
      await doc.ref.delete()
    })

    const calendarUser = await db.collectionGroup('calendar_user').where('uid','==', uid).orderBy('created', 'desc').get()
    console.log(calendarUser)
    calendarUser.docs.map(async (doc: {ref: any;}) => {
      console.log(doc)
      await doc.ref.delete()
    })

    const notification = await db.collectionGroup('notification').where('uid','==', uid).orderBy('created', 'desc').get()
    logger.log(notification)
    notification.docs.map(async (doc: {ref: any;}) => {
      await doc.ref.delete()
    })

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
    const snapshots = await db.collection('token').where('uid', '==', uid).get()
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