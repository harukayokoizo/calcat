import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_calendar/src/features/event/application/event_provider.dart';

import '../../../common_widgets/application/common_provider.dart';
import '../../notification/data/personal_event_notification_repositories.dart';
import '../application/event_list_provider.dart';
import '../domain/event_document.dart';
import '../domain/event.dart';

final eventRepositories = Provider.autoDispose((ref) => EventRepositories(ref));

class EventRepositories{
  Ref ref;

  EventRepositories(this.ref);

  //personal_eventコレクションからイベントを取得する
  Stream<List<EventDocument>> getEvent(String calendarMonth) async*{
    final currentUser = ref.read(currentUserProvider);
    var events = FirebaseFirestore.instance
        .collection('event')
        .where('uid', isEqualTo: currentUser!.uid)
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

  Future<List<DateTime>> getSameEventDate(String sameEventId) async{
    final currentUser = ref.read(currentUserProvider);
    List<DateTime> events = [];
    await FirebaseFirestore.instance
        .collection('event')
        .where('uid', isEqualTo: currentUser!.uid)
        .where('sameEventId', isEqualTo: sameEventId)
        .get()
        .asStream()
        .forEach((element) {
          for(var event in element.docs){
            Event eventDoc = Event.fromJson(event.data());
            DateTime from = DateTime.utc(eventDoc.from!.year,eventDoc.from!.month, eventDoc.from!.day);
            events.add(from);
          }
    });

    return events;
  }

  Future<void> createEvent(List events) async{
    WriteBatch batch = FirebaseFirestore.instance.batch();
    final docId = FirebaseFirestore.instance.collection('event').doc().id;
    final db = FirebaseFirestore.instance.collection('event');

    for(var data in events){
      data['sameEventId'] = docId;
      batch.set(db.doc(), data);
    }

    await batch.commit();
  }

  Future<bool> getSingleEvent(String docId) async{
    var eventDoc = await FirebaseFirestore.instance
        .collection('event')
        .doc(docId)
        .get();

    if(eventDoc.data() != null){
      final Event event = Event.fromJson(eventDoc.data()!);
      return event.notificationExist!;
    }

    return false;
  }

  Future<void> updateEvent(Map<String, dynamic> event, String docId) async{
    final newId = FirebaseFirestore.instance.collection('event').doc().id;
    event['sameEventId'] = newId;
    await FirebaseFirestore.instance
        .collection('event')
        .doc(docId)
        .update(event);
  }

  Future<void> changeNotificationExist(Map<String, dynamic> event, String docId) async{
    await FirebaseFirestore.instance
        .collection('event')
        .doc(docId)
        .update(event);
  }

  Future<void> deleteAndUpdateEvent(List deleteEvents, List createEvents) async{
    WriteBatch batch = FirebaseFirestore.instance.batch();
    final db = FirebaseFirestore.instance.collection('event');
    final docId = FirebaseFirestore.instance.collection('event').doc().id;

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
    final eventCollection = FirebaseFirestore.instance.collection('event');
    batch.delete(eventCollection.doc(eventDoc.docId));

    await batch.commit();
  }

  Future<void> deleteSameEvents(EventDocument eventDoc) async{
    WriteBatch batch = FirebaseFirestore.instance.batch();
    final eventCollection = FirebaseFirestore.instance.collection('event');
    List deleteEvents = await getSameEvent(eventDoc.event!.sameEventId!);

    for(var data in deleteEvents){
      batch.delete(eventCollection.doc(data));
    }

    await batch.commit();
  }
}