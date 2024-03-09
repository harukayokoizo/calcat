import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_calendar/src/features/personal_event/application/personal_event_provider.dart';

import '../../../common_widgets/application/common_provider.dart';
import '../domain/event_document.dart';
import '../domain/personal_event.dart';

final personalEventRepositories = Provider.autoDispose((ref) => PersonalEventRepositories(ref));

class PersonalEventRepositories{
  Ref ref;

  PersonalEventRepositories(this.ref);

  //personal_eventコレクションからイベントを取得する
  Stream<List<EventDocument>> getEvent() async*{
    final currentUser = ref.read(currentUserProvider);
    var events = FirebaseFirestore.instance
        .collection('personal_events')
        .where('uid', isEqualTo: currentUser!.uid)
        .snapshots().map(
            (snapshots) => snapshots.docs.map(
                    (e){
                      var personalEvent = PersonalEvent.fromJson(e.data());
                      var event = EventDocument(event:personalEvent, docId: e.id);
                      return event;
                    }).toList());

    yield* events;
  }

  Future<List<dynamic>> getSameEvent(String sameEventId) async{
    final currentUser = ref.read(currentUserProvider);
    List events = [];
    await FirebaseFirestore.instance
        .collection('personal_events')
        .where('uid', isEqualTo: currentUser!.uid)
        .where('sameEventId', isEqualTo: sameEventId)
        .get()
        .asStream()
        .forEach((element) {
          for(var event in element.docs){
            PersonalEvent personalEvent = PersonalEvent.fromJson(event.data());
            events.add(personalEvent);
          }
        });

    return events;
  }

  Future<void> createEvent(List events) async{
    WriteBatch batch = FirebaseFirestore.instance.batch();
    final docId = FirebaseFirestore.instance.collection('personal_events').doc().id;
    final db = FirebaseFirestore.instance.collection('personal_events');

    for(var data in events){
      data['sameEventId'] = docId;
      batch.set(db.doc(), data);
    }

    await batch.commit();
  }

  Future<void> updateEvent(List events) async{
    WriteBatch batch = FirebaseFirestore.instance.batch();
    final docId = FirebaseFirestore.instance.collection('personal_events').doc().id;
    final db = FirebaseFirestore.instance.collection('personal_events');

    for(var data in events){
      data['sameEventId'] = docId;
      batch.set(db.doc(), data);
    }

    await batch.commit();
  }
}