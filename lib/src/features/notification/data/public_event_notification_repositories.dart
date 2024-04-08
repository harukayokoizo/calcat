import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../common_widgets/application/common_provider.dart';
import '../../event/domain/event_document.dart';
import '../domain/notification.dart';

final publicEventNotificationRepositories = Provider.family<PublicEventNotificationRepositories, EventDocument>(
        (ref, eventDoc){
          var user = ref.read(currentUser);
          return PublicEventNotificationRepositories(user!.uid, eventDoc);
        });

class PublicEventNotificationRepositories{
  String uid;
  EventDocument eventDoc;
  String calendarId;
  String eventId;
  PublicEventNotificationRepositories(this.uid, this.eventDoc) :
        eventId = eventDoc.docId!,
        calendarId = eventDoc.event!.calendarId!;

  Future<void> createNotification() async{
    DateTime date = DateTime.now();
    await FirebaseFirestore.instance
        .collection('calendar')
        .doc(calendarId)
        .collection('event')
        .doc(eventId)
        .collection('notification')
        .doc(uid)
        .set(
        {
          'uid': uid,
          'created': date,
        });
  }

  Stream<bool> getNotification() async*{
    var exists = FirebaseFirestore.instance
        .collection('calendar')
        .doc(calendarId)
        .collection('event')
        .doc(eventId)
        .collection('notification')
        .doc(uid)
        .snapshots()
        .map((snapshot) => snapshot.exists);

    yield* exists;
  }

  Future<List<Notification>> getAllNotification() async{
    final List<Notification> notifications = [];
    await FirebaseFirestore.instance
        .collection('calendar')
        .doc(calendarId)
        .collection('event')
        .doc(eventId)
        .collection('notification')
        .get().then((snapshots){
      for (var e in snapshots.docs) {
        Notification notification = Notification.fromJson(e.data());
        notifications.add(notification);
      }
    });

    return notifications;
  }

  Future<void> deleteNotification() async{
    await FirebaseFirestore.instance
        .collection('calendar')
        .doc(calendarId)
        .collection('event')
        .doc(eventId)
        .collection('notification')
        .doc(uid)
        .delete();
  }
}