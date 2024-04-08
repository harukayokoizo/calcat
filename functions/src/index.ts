import {
  onDocumentCreated,
  onDocumentDeleted,
} from "firebase-functions/v2/firestore";
import 'package:share_calendar/src/features/personal_event/domain/event.dart';
import 'package:share_calendar/src/features/personal_event/domain/event_document.dart';

const { initializeApp } = require('firebase-admin/app');
const { getFirestore, FieldValue } = require('firebase-admin/firestore');
const { onSchedule } = require("firebase-functions/v2/scheduler");
const { logger } = require("firebase-functions");

initializeApp();
const db = getFirestore();

exports.incrementFollow = onDocumentCreated("calendar/{calendarId}/calendar_user/{userId}", (calendarUser) => {
  const docId = calendarUser.params.calendarId;
  db.doc("calendar/" + docId).update({ followsCount: FieldValue.increment(1.0) });
});

exports.decrementFollow = onDocumentDeleted("calendar/{calendarId}/calendar_user/{userId}", (event) => {
  const docId = event.params.calendarId;
  db.doc("calendar/" + docId).update({ followsCount: FieldValue.increment(-1.0) });
});

exports.scheduledEventNotification = onSchedule("* * * * *", async () => {
  logger.log('Hello');
  final List events = [];
  // 現在時刻を取得
  const now = (() => {
    let s = db.Timestamp.now().seconds
    s = s - s % 60
    return new db.Timestamp(s, 0)
  })()
  // コレクショングループeventでfromが現在時刻と一致するものを取得
  db.collectionGroup('event').where('from', isEqualTo: now).get()
    .then((querySnapshot){
      for(var event in querySnapshot){
        var event = Event.fromJson(event.data());
        var eventDoc = EventDocument(docId: event.id, event: event);
        events.add(eventDoc);
      }
    });
  if(events.isNotEmpty){
    for(var event in events){
      db.collection
    }
  }
  // 取得したドキュメントの通知サブコレクションのドキュメントを全部取得
  // 各ドキュメントのuserReferenceの値からUserコレクションのドキュメントを取得（トークンを取得）
  // 通知する。
});

async function sendPushNotificationsForReminder(reminders: Model.Reminder[]) {
  const messages: admin.messaging.Message[] = []
  for (const reminder of reminders) {
    // ユーザーのトークンは複数ある可能性があるので、ユーザーのトークン分メッセージを作る
    const msgs: admin.messaging.Message[] = reminder.tokens.map((token) => {
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
      .then((batchResponse) => {
        batchResponse.responses.forEach((res) => {
          // FCM側でエラーが発生した場合、StackDriverにログを残す
          if (res.error) {
            console.error(res.error)
          }
        })
        console.log(`send messages: ${ms.length} count`)
      })
      .catch((e) => {
        console.error(e)
      })
    )
  await Promise.all(promises)
}


