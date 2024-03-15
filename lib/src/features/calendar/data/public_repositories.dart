import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_calendar/src/features/personal_event/application/event_provider.dart';

import '../../../common_widgets/application/common_provider.dart';
import '../../personal_event/domain/event.dart';
import '../../personal_event/domain/event_document.dart';

final publicEventRepositories = Provider.autoDispose((ref) => PublicEventRepositories(ref));

class PublicEventRepositories{
  Ref ref;

  PublicEventRepositories(this.ref);

  //personal_eventコレクションからイベントを取得する
  Stream<List<EventDocument>> getEvent(String docId) async*{
    final currentUser = ref.read(currentUserProvider);
    var events = FirebaseFirestore.instance
        .collection('calendar')
        .doc(docId)
        .collection('event')
        .snapshots().map(
            (snapshots) => snapshots.docs.map(
                (e){
              var personalEvent = Event.fromJson(e.data());
              var event = EventDocument(event:personalEvent, docId: e.id);
              return event;
            }).toList());

    yield* events;
  }

  // Future<List<EventDocument>> getEvent(String docId) async{
  //   List<EventDocument> events = [];
  //   await FirebaseFirestore.instance
  //       .collection('calendar')
  //       .doc(docId)
  //       .collection('event')
  //       .get().asStream()
  //       .forEach((element) {
  //     for(var doc in element.docs){
  //       var personalEvent = Event.fromJson(doc.data());
  //       var event = EventDocument(event:personalEvent, docId: doc.id);
  //       events.add(event);
  //     }
  //   });
  //
  //   return events;
  // }

  // Future<List<dynamic>> getSameEvent(String sameEventId) async{
  //   final currentUser = ref.read(currentUserProvider);
  //   List events = [];
  //   await FirebaseFirestore.instance
  //       .collection('personal_events')
  //       .where('uid', isEqualTo: currentUser!.uid)
  //       .where('sameEventId', isEqualTo: sameEventId)
  //       .get()
  //       .asStream()
  //       .forEach((element) {
  //     for(var event in element.docs){
  //       //PersonalEvent personalEvent = PersonalEvent.fromJson(event.data());
  //       events.add(event.id);
  //     }
  //   });
  //
  //   return events;
  // }
  //
  // Future<void> createEvent(List events) async{
  //   WriteBatch batch = FirebaseFirestore.instance.batch();
  //   final docId = FirebaseFirestore.instance.collection('personal_events').doc().id;
  //   final db = FirebaseFirestore.instance.collection('personal_events');
  //
  //   for(var data in events){
  //     data['sameEventId'] = docId;
  //     batch.set(db.doc(), data);
  //   }
  //
  //   await batch.commit();
  // }
  //
  // Future<void> updateEvent(Map<String, dynamic> event, String docId) async{
  //   final newId = FirebaseFirestore.instance.collection('personal_events').doc().id;
  //   event['sameEventId'] = newId;
  //   await FirebaseFirestore.instance
  //       .collection('personal_events')
  //       .doc(docId)
  //       .update(event);
  // }
  //
  // Future<void> deleteAndUpdateEvent(List deleteEvents, List createEvents) async{
  //   WriteBatch batch = FirebaseFirestore.instance.batch();
  //   final db = FirebaseFirestore.instance.collection('personal_events');
  //   final docId = FirebaseFirestore.instance.collection('personal_events').doc().id;
  //
  //   for(var data in deleteEvents){
  //     batch.delete(db.doc(data));
  //   }
  //
  //   for(var data in createEvents){
  //     data['sameEventId'] = docId;
  //     batch.set(db.doc(), data);
  //   }
  //
  //   await batch.commit();
  // }
  //
  // Future<void> deleteEvent(String docId) async{
  //   await FirebaseFirestore.instance
  //       .collection('personal_events')
  //       .doc(docId)
  //       .delete();
  // }
  //
  // Future<void> deleteSameEvents(EventDocument eventDoc) async{
  //   List deleteEvents = await getSameEvent(eventDoc.event!.sameEventId!);
  //   WriteBatch batch = FirebaseFirestore.instance.batch();
  //   final db = FirebaseFirestore.instance.collection('personal_events');
  //
  //   for(var data in deleteEvents){
  //     batch.delete(db.doc(data));
  //   }
  //
  //   await batch.commit();
  // }
}