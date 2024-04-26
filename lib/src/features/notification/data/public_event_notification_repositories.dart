import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../common_widgets/application/common_provider.dart';
import '../../event/domain/event_document.dart';
import '../domain/notification.dart';

final publicEventNotificationRepositories = Provider.autoDispose.family<PublicEventNotificationRepositories, EventDocument>(
        (ref, eventDoc){
          var user = ref.read(currentUserProvider);
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
    bool exist = await getNotification();
    if(!exist){
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
  }

  Future<bool> getNotification() async{
    var snapshot = await FirebaseFirestore.instance
        .collection('calendar')
        .doc(calendarId)
        .collection('event')
        .doc(eventId)
        .collection('notification')
        .doc(uid)
        .get();

    return snapshot.exists;
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
    bool exist = await getNotification();
    if(exist){
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

  Future<List<dynamic>> deleteAllNotification() async{
    List notifications = [];
    await FirebaseFirestore.instance
        .collection('calendar')
        .doc(calendarId)
        .collection('event')
        .doc(eventId)
        .collection('notification')
        .get()
        .asStream()
        .forEach((element) {
          for (var element in element.docs) {
            notifications.add(element.id);
          }
        });

    return notifications;
  }
}