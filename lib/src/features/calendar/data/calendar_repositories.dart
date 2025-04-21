import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../common_widgets/application/common_provider.dart';
import '../domain/calendar.dart';
import '../domain/calendar_document.dart';

final calendarRepositories = Provider.autoDispose((ref) => CalendarRepositories(ref));

class CalendarRepositories {
  Ref ref;

  CalendarRepositories(this.ref);

  //personal_eventコレクションからイベントを取得する
  Stream<List<CalendarDocument>> getCalendarList(User? user) async*{
    try {
      // final currentUser = ref.read(currentUserProvider);
      if (user == null) {
        yield* const Stream.empty();
      }
      var calendars = FirebaseFirestore.instance
          .collection('calendar')
          .where('calendarOwner', arrayContainsAny: [user?.uid])
          .orderBy('updated', descending: true)
          .snapshots().map(
              (snapshots) =>
              snapshots.docs.map(
                      (e) {
                    var calendar = Calendar.fromJson(e.data());
                    var calendarDoc = CalendarDocument(
                        calendar: calendar, docId: e.id);
                    return calendarDoc;
                  }).toList());

      yield* calendars;
    }catch (e){
      print(e.toString());
    }
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

  Future<bool> getCalendarOwner(String docId, String uid) async{
    try {
      final calendarDoc = await FirebaseFirestore.instance
          .collection('calendar')
          .doc(docId)
          .get();

      if (calendarDoc.exists) {
        Calendar calendar = Calendar.fromJson(calendarDoc.data()!);
        List<String> owner = calendar.calendarOwner!;
        return owner.contains(uid);
      } else {
        return false;
      }
    }catch (e){
      throw e.toString();
    }
  }

  Future<bool> getCalendarPublicPreference(String docId) async{
    try {
      final calendarDoc = await FirebaseFirestore.instance
          .collection('calendar')
          .doc(docId)
          .get();

      if (calendarDoc.exists) {
        Calendar calendar = Calendar.fromJson(calendarDoc.data()!);
        return calendar.publicPreference == 0 ? false : true;
      } else {
        return false;
      }
    }catch (e){
      return false;
    }
  }

  Future<String?> getSameCalendar(String title, String password) async{
    final sameCalendar = await FirebaseFirestore.instance
        .collection('calendar')
        .where('title', isEqualTo: title)
        .where('password', isEqualTo: password)
        .where('publicPreference', isEqualTo: 2)
        .get();

    if(sameCalendar.docs.isNotEmpty){
      for (var e in sameCalendar.docs) {
        return e.id;
      }
      return null;
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

  Future<void> editCalendar(Map<String, dynamic> data, String docId) async{
    try {
      await FirebaseFirestore.instance
          .collection('calendar')
          .doc(docId)
          .update(data);
    }catch (e){
      throw('保存に失敗しました。');
    }
  }

  Future<List<CalendarDocument>> searchCalendar(String value) async{
    List<CalendarDocument> calendars = [];
    var calendarList = await FirebaseFirestore.instance
        .collection('calendar')
        .where('searchIndex', arrayContainsAny: [value])
        .where('publicPreference', isEqualTo: 1)
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
        .where('publicPreference', isEqualTo: 1)
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
        .where('publicPreference', isEqualTo: 1)
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
        .where('publicPreference', isEqualTo: 2)
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