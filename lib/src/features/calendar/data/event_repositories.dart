import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_calendar/src/features/event/application/event_provider.dart';

import '../../../common_widgets/application/common_provider.dart';
import '../../event/domain/event.dart';
import '../../event/domain/event_document.dart';
import '../../notification/data/public_event_notification_repositories.dart';

final publicEventRepositories = Provider.autoDispose.family<PublicEventRepositories, String>(
        (ref, docId) => PublicEventRepositories(ref, docId)
);

class PublicEventRepositories{
  Ref ref;
  String calendarDocId;

  PublicEventRepositories(this.ref, this.calendarDocId);

  //personal_eventコレクションからイベントを取得する
  Stream<List<EventDocument>> getEvent(String calendarMonth) async*{
    print(calendarMonth);
    print('stream');
    var events = FirebaseFirestore.instance
        .collection('calendar')
        .doc(calendarDocId)
        .collection('event')
        .where('calendarMonth', isEqualTo: calendarMonth)
        .snapshots().map(
            (snapshots) => snapshots.docs.map(
                (e){
              var personalEvent = Event.fromJson(e.data());
              var event = EventDocument(event:personalEvent, docId: e.id);
              return event;
            }).toList());

    yield* events;
  }

  Future<List<dynamic>> getSameEvent(String sameEventId) async{
    final currentUser = ref.read(currentUserProvider);
    List events = [];
    await FirebaseFirestore.instance
        .collection('calendar')
        .doc(calendarDocId)
        .collection('event')
        .where('uid', isEqualTo: currentUser!.uid)
        .where('sameEventId', isEqualTo: sameEventId)
        .get()
        .asStream()
        .forEach((element) {
          for(var event in element.docs){
            //PersonalEvent personalEvent = PersonalEvent.fromJson(event.data());
            events.add(event.id);
          }
        });

    return events;
  }

  Future<void> createEvent(List events) async{
    WriteBatch batch = FirebaseFirestore.instance.batch();
    final docId = FirebaseFirestore.instance.collection('calendar').doc(calendarDocId).collection('event').doc().id;
    final db = FirebaseFirestore.instance.collection('calendar').doc(calendarDocId).collection('event');

    for(var data in events){
      data['sameEventId'] = docId;
      batch.set(db.doc(), data);
    }

    await batch.commit();
  }

  Future<void> updateEvent(Map<String, dynamic> event, String docId) async{
    final newId = FirebaseFirestore.instance.collection('calendar').doc(calendarDocId).collection('event').doc().id;
    event['sameEventId'] = newId;
    await FirebaseFirestore.instance
        .collection('calendar')
        .doc(calendarDocId)
        .collection('event')
        .doc(docId)
        .update(event);
  }

  Future<void> deleteAndUpdateEvent(List deleteEvents, List createEvents) async{
    WriteBatch batch = FirebaseFirestore.instance.batch();
    final db = FirebaseFirestore.instance.collection('calendar').doc(calendarDocId).collection('event');
    final docId = FirebaseFirestore.instance.collection('calendar').doc(calendarDocId).collection('event').doc().id;

    for(var data in deleteEvents){
      batch.delete(db.doc(data));
    }

    for(var data in createEvents){
      data['sameEventId'] = docId;
      batch.set(db.doc(), data);
    }

    await batch.commit();
  }

  Future<void> deleteEvent(EventDocument eventDoc) async{
    WriteBatch batch = FirebaseFirestore.instance.batch();
    final eventCollection = FirebaseFirestore.instance.collection('calendar').doc(calendarDocId).collection('event');
    final notificationCollection = FirebaseFirestore.instance.collection('calendar').doc(calendarDocId).collection('event').doc(eventDoc.docId).collection('notification');

    List deleteNotification = await ref.read(publicEventNotificationRepositories(eventDoc)).deleteAllNotification();

    batch.delete(eventCollection.doc(eventDoc.docId));

    for(var data in deleteNotification){
      batch.delete(notificationCollection.doc(data));
    }

    await batch.commit();
  }

  Future<void> deleteSameEvents(EventDocument eventDoc) async{
    WriteBatch batch = FirebaseFirestore.instance.batch();
    final eventCollection = FirebaseFirestore.instance.collection('calendar').doc(calendarDocId).collection('event');
    final notificationCollection = FirebaseFirestore.instance.collection('calendar').doc(calendarDocId).collection('event').doc(eventDoc.docId).collection('notification');
    List deleteEvents = await getSameEvent(eventDoc.event!.sameEventId!);
    List deleteNotification = await ref.read(publicEventNotificationRepositories(eventDoc)).deleteAllNotification();

    for(var data in deleteEvents){
      batch.delete(eventCollection.doc(data));
    }

    for(var data in deleteNotification){
      batch.delete(notificationCollection.doc(data));
    }

    await batch.commit();
  }
}