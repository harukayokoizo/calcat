import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../common_widgets/application/common_provider.dart';
import '../../event/domain/event_document.dart';
import '../domain/notification.dart';

final personalEventNotificationRepositories = Provider.autoDispose.family<PersonalEventNotificationRepositories, EventDocument>(
        (ref, eventDoc){
          var user = ref.read(currentUserProvider);
          return PersonalEventNotificationRepositories(user!.uid, eventDoc);
        });

class PersonalEventNotificationRepositories{
  String uid;
  EventDocument eventDoc;
  String eventId;
  PersonalEventNotificationRepositories(this.uid, this.eventDoc):
        eventId = eventDoc.docId!;

  Future<void> createNotification() async{
    DateTime date = DateTime.now();
    await FirebaseFirestore.instance
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
        .collection('event')
        .doc(eventId)
        .collection('notification')
        .doc(uid)
        .delete();
  }

  Future<List<dynamic>> deleteAllNotification() async{
    List notifications = [];
    await FirebaseFirestore.instance
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