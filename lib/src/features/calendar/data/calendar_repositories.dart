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
  Stream<List<CalendarDocument>> getCalendarList() async*{
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

  Stream<CalendarDocument> getCalendar(String docId) async*{
    var calendarDoc = FirebaseFirestore.instance
        .collection('calendar')
        .doc(docId)
        .snapshots()
        .map(
            (e){
              Calendar calendar = Calendar.fromJson(e.data()!);
              return CalendarDocument(calendar:calendar, docId: e.id);
            });

    yield* calendarDoc;
  }

  Future<String?> getSameCalendar(String title, String password) async{
    final sameCalendar = await FirebaseFirestore.instance
        .collection('calendar')
        .where('title', isEqualTo: title)
        .where('password', isEqualTo: password)
        .where('publicPreference', isEqualTo: false)
        .get();

    if(sameCalendar.docs.isNotEmpty){
      for (var e in sameCalendar.docs) {
        return e.id;
      }
    }else{
      return null;
    }
  }

  Future<String?> createCalendar(Map<String, dynamic> data) async{
    try {
      final calendar = await FirebaseFirestore.instance
          .collection('calendar')
          .add(data);

      return calendar.id;
    }catch (e){
      return null;
    }
  }

  Future<String?> editCalendar(Map<String, dynamic> data, String docId) async{
    try {
      final calendar = await FirebaseFirestore.instance
          .collection('calendar')
          .doc(docId)
          .update(data);

      return null;
    }catch (e){
      return null;
    }
  }

  Future<List<CalendarDocument>> searchCalendar(String value) async{
    List<CalendarDocument> calendars = [];
    var calendarList = await FirebaseFirestore.instance
        .collection('calendar')
        .where('searchIndex', arrayContainsAny: [value])
        .where('publicPreference', isEqualTo: true)
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

  Future<List<CalendarDocument>> searchCalendarList(String value) async{
    List<CalendarDocument> calendars = [];
    var calendarList = await FirebaseFirestore.instance
        .collection('calendar')
        .where('searchIndex', arrayContainsAny: [value])
        .where('publicPreference', isEqualTo: true)
        .orderBy('followsCount', descending: true)
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

  Future<List<CalendarDocument>> followRankingList() async{
    List<CalendarDocument> calendars = [];
    var calendarList = await FirebaseFirestore.instance
        .collection('calendar')
        .where('publicPreference', isEqualTo: true)
        .orderBy('followsCount', descending: true)
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

  Future<List<CalendarDocument>> searchLimitedCalendar(String calendarTitle, String password) async{
    List<CalendarDocument> calendars = [];
    var calendarList = await FirebaseFirestore.instance
        .collection('calendar')
        .where('title', isEqualTo: calendarTitle)
        .where('password', isEqualTo: password)
        .where('publicPreference', isEqualTo: false)
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

  Future<void> deleteCalendar(String docId) async{
    await FirebaseFirestore.instance
        .collection('calendar')
        .doc(docId)
        .delete();
  }
}