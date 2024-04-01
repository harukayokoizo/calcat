/**
 * Import function triggers from their respective submodules:
 *
 * import {onCall} from "firebase-functions/v2/https";
 * import {onDocumentWritten} from "firebase-functions/v2/firestore";
 *
 * See a full list of supported triggers at https://firebase.google.com/docs/functions
 */

import "firebase-admin/app";
import "firebase-admin/firestore";
const db = require("firebase-admin").firestore;
const FieldValue = require("firebase-admin").firestore.FieldValue;

import {
  onDocumentCreated,
} from "firebase-functions/v2/firestore";

exports.writeCalendar = onDocumentCreated(
  "calendar/{calendarId}/calendar_user/{userId}",
  (calendarUser) => {
    const docId = calendarUser.params.calendarId;
    db.doc("calendar/"+docId).set({followsCount: FieldValue.increment(1.0)});
  });
// calendarコレクション下calendar_userコレクションにドキュメントが追加されか検知する
// 追加されたらcalendarコレクションのfollowに+1する
// 削除されたらcalendarコレクションのfollowに+1する
