import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../common_widgets/application/common_provider.dart';
import '../../personal_event/domain/calendar_user.dart';
import '../domain/calendar.dart';
import '../domain/calendar_document.dart';

final calendarUserRepositories = Provider.autoDispose((ref) => CalendarUserRepositories(ref));

class CalendarUserRepositories {
  Ref ref;

  CalendarUserRepositories(this.ref);

  //personal_eventコレクションからイベントを取得する
  Stream<List<CalendarUser>> getAllFollowCalendar() async*{
    final currentUser = ref.read(currentUserProvider);
    var calendars = FirebaseFirestore.instance
        .collectionGroup('calendar_user')
        .where('uid', isEqualTo: currentUser!.uid)
        .orderBy('created', descending: true)
        .snapshots().map(
            (snapshots) => snapshots.docs.map(
                (e){
                  final calendar = CalendarUser.fromJson(e.data());
                  return calendar;
            }).toList());

    yield* calendars;
  }

  Future<CalendarDocument> getFollowCalendarDocument(DocumentReference<dynamic> calendarReference) async{
    var calendarDoc = await calendarReference.get();
    Calendar calendar = Calendar.fromJson(calendarDoc.data()!);
    CalendarDocument calendarDocument = CalendarDocument(calendar: calendar, docId: calendarDoc.id);
    return calendarDocument;
  }

  Future<bool> getFollowCalendar(String docId) async{
    bool follow = false;
    final currentUser = ref.read(currentUserProvider);
    var calendar = await FirebaseFirestore.instance
        .collection('calendar')
        .doc(docId)
        .collection('calendar_user')
        .doc(currentUser!.uid)
        .get();

    if(calendar.exists){
      follow = true;
    }

    return follow;
  }

  Future<void> createCalendarUser(String docId) async{
    final DateTime created = DateTime.now();
    final currentUser = ref.read(currentUserProvider);
    final DocumentReference calendar = FirebaseFirestore.instance.collection('calendar').doc(docId);
    await FirebaseFirestore.instance
        .collection('calendar')
        .doc(docId)
        .collection('calendar_user')
        .doc(currentUser!.uid)
        .set(
        {
          'calendar': calendar,
          'created': created,
          'uid': currentUser.uid
        }
        );
  }

  Future<void> deleteFollowCalendar(String docId) async{
    final currentUser = ref.read(currentUserProvider);
    await FirebaseFirestore.instance
        .collection('calendar')
        .doc(docId)
        .collection('calendar_user')
        .doc(currentUser!.uid)
        .delete();
  }
}