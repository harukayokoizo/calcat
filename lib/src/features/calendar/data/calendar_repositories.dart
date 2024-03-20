import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../common_widgets/application/common_provider.dart';
import '../domain/calendar.dart';
import '../domain/calendar_document.dart';

final calendarRepositories = Provider.autoDispose((ref) => CalendarRepositories(ref));

class CalendarRepositories {
  Ref ref;

  CalendarRepositories(this.ref);

  //personal_eventコレクションからイベントを取得する
  Stream<List<CalendarDocument>> getCalendar() async*{
    final currentUser = ref.read(currentUserProvider);
    var calendars = FirebaseFirestore.instance
        .collection('calendar')
        .where('author', isEqualTo: currentUser!.uid)
        .snapshots().map(
            (snapshots) => snapshots.docs.map(
                (e){
                  var calendar = Calendar.fromJson(e.data());
                  var calendarDoc = CalendarDocument(calendar:calendar, docId: e.id);
                  return calendarDoc;
                }).toList());

    yield* calendars;
  }

  Future<void> createCalendar(Map<String, dynamic> data) async{
    await FirebaseFirestore.instance
        .collection('calendar')
        .add(data);
  }

  Future<List<CalendarDocument>> searchCalendar(String value) async{
    List<CalendarDocument> calendars = [];
    var calendarList = await FirebaseFirestore.instance
        .collection('calendar')
        .where('searchIndex', arrayContainsAny: [value])
        .get();

    if(calendarList.docs.isNotEmpty){
      for (var e in calendarList.docs) {
        var calendar = Calendar.fromJson(e.data());
        var calendarDoc = CalendarDocument(docId: e.id, calendar: calendar);
        calendars.add(calendarDoc);
      }
      return calendars;
    }else{
      return calendars;
    }
  }
}