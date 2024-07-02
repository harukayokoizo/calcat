import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../event/domain/event.dart';
import '../../event/domain/event_document.dart';
import '../data/event_repositories.dart';
import '../domain/calendar_document.dart';
import '../domain/calendar_event.dart';

final calendarIdProvider = StateProvider.autoDispose.family<String?, String>((ref,calendarId) => calendarId);

final publicCalendarFormat = StateProvider.autoDispose<CalendarFormat?>((ref) => null);

final publicFocusedDay = StateNotifierProvider.autoDispose<PublicFocusedDay, DateTime>(
        (ref) {
          return PublicFocusedDay();
        }
);

class PublicFocusedDay extends StateNotifier<DateTime>{
  PublicFocusedDay() : super(DateTime.now());

  void saveState({required DateTime focusedDay}){
    DateTime day = DateTime(focusedDay.year,focusedDay.month,focusedDay.day);
    state = day;
  }

}

final publicEvents = StreamProvider.autoDispose.family<List<EventDocument>,CalendarEvent>(
        (ref, calendarEvent) async*{
          yield* ref.read(publicEventRepositories(calendarEvent.calendarId)).getEvent(calendarEvent.calendarMonth);
        });

final publicEventList = StateNotifierProvider.autoDispose.family<PublicEventListController, Map<dynamic, dynamic>, CalendarEvent>(
        (ref, calendarEvent) {
          final events = ref.watch(publicEvents(calendarEvent));
          return PublicEventListController(ref, events);
        }
);

class PublicEventListController extends StateNotifier<Map<dynamic, dynamic>>{
  AsyncValue<List<EventDocument>> events;
  Ref ref;

  PublicEventListController(this.ref, this.events) : super({}){
    Map<DateTime, List<EventDocument>> eventsDisplay = {};

    events.whenData((value){
      eventsDisplay = changeFormat(value);
      eventsDisplay = sortEventList(eventsDisplay);
      state = eventsDisplay;
    });
  }

  Map<DateTime, List<EventDocument>> changeFormat(List<EventDocument> events){
    final Map<DateTime, List<EventDocument>> eventList = {};
    for(final EventDocument eventDoc in events){
      Event event = eventDoc.event!;
      List keyDate = [];
      DateTime? from = event.from;
      DateTime? to = event.to;
      from = DateTime.utc(from!.year, from.month, from.day);
      to = DateTime.utc(to!.year, to.month, to.day);
      if(from == to){
        //イベントの開始日と終了日が同じの場合
        keyDate = [from];
      }else{
        for(int i = 0;i <= to.difference(from).inDays;i++){
          keyDate.add(from.add(Duration(days: i)));
        }
      }

      //eventListにMap<DateTime, List<PersonalEvent>>を追加する
      for(var date in keyDate){
        //eventListにdateのkeyが存在するかチェックする
        var containDate = eventList.containsKey(date);
        if(containDate){
          List<EventDocument> value = eventList[date]!;
          value.add(eventDoc);
          eventList[date] = value;
        }else{
          eventList.addAll({date : [eventDoc]});
        }
      }
    }
    return eventList;
  }

  Map<DateTime, List<EventDocument>> sortEventList(Map<DateTime, List<EventDocument>> eventMap){
    final Map<DateTime, List<EventDocument>> sortEventMap = {};
    eventMap.forEach((date, events) {
      events.sort((a, b) => a.event!.from!.compareTo(b.event!.from!));
      sortEventMap.addAll({date : events});
    });

    return sortEventMap;
  }
}


// 閲覧した月の「personalEventList:イベント取得用クラス」のプロバイダーを格納するクラスを提供する
final publicEventStream = StateNotifierProvider.autoDispose.family<PublicEventStream, List<dynamic>, String>(
        (ref, calendarId) {
          DateTime today = DateTime.now();
          String month = '${today.year}年${today.month}月';
          String nextMonth = '${today.year}年${today.month + 1}月';
          CalendarEvent monthEvent = CalendarEvent(calendarId, month);
          CalendarEvent nextMonthEvent = CalendarEvent(calendarId, nextMonth);
          return PublicEventStream([publicEventList(monthEvent), publicEventList(nextMonthEvent)]);
        }
);

class PublicEventStream extends StateNotifier<List<dynamic>>{
  List<dynamic> streamList;
  PublicEventStream(this.streamList) : super(streamList);

  void addStream(dynamic stream){
    state = [...state, stream];
  }

}