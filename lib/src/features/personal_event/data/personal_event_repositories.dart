import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
}