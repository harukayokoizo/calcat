import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_calendar/src/features/personal_event/application/personal_event_provider.dart';

import '../../../common_widgets/application/common_provider.dart';
import '../domain/personal_event.dart';

final personalEventRepositories = Provider.autoDispose((ref) => PersonalEventRepositories(ref));

class PersonalEventRepositories{
  Ref ref;

  PersonalEventRepositories(this.ref);

  //personal_eventコレクションからイベントを取得する
  Stream<List<PersonalEvent>> getEvent() async*{
    final currentUser = ref.read(currentUserProvider);
    var events = FirebaseFirestore.instance
        .collection('personal_events')
        .where('uid', isEqualTo: currentUser!.uid)
        .snapshots().map(
            (snapshots) => snapshots.docs.map(
                    (e){
                      var event = PersonalEvent.fromJson(e.data());
                      return event;
                    }).toList());

    yield* events;
  }

  Future<void> createEvent() async{
    final personalEvent = ref.read(personalEventFormStateProvider);
    var event = await FirebaseFirestore.instance
        .collection('personal_events')
        .add(
        {
          'uid': personalEvent.uid,
          'title': personalEvent.title,
          'event': personalEvent.event,
          'image': personalEvent.image,
          'color': personalEvent.color,
          'isAllDay': personalEvent.isAllDay,
          'from': personalEvent.from,
          'to': personalEvent.to,
          'notification': personalEvent.notification,
          'repeat': personalEvent.repeat,
          'endDate': personalEvent.endDate,
          'sameEventId': personalEvent.sameEventId,
          'number': personalEvent.number,
        }
        );
  }
}