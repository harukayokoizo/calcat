/**
 * Import function triggers from their respective submodules:
 *
 * import {onCall} from "firebase-functions/v2/https";
 * import {onDocumentWritten} from "firebase-functions/v2/firestore";
 *
 * See a full list of supported triggers at https://firebase.google.com/docs/functions
 */

import {
  onDocumentCreated,
  onDocumentDeleted,
} from "firebase-functions/v2/firestore";

const { initializeApp } = require('firebase-admin/app');
const { getFirestore, FieldValue } = require('firebase-admin/firestore');

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

// Start writing functions
// https://firebase.google.com/docs/functions/typescript

// export const helloWorld = onRequest((request, response) => {
//   logger.info("Hello logs!", {structuredData: true});
//   response.send("Hello from Firebase!");
// });
