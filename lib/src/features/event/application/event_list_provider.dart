import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_calendar/src/features/calendar/domain/calendar.dart';
import 'package:table_calendar/table_calendar.dart';

import '../data/personal_event_repositories.dart';
import '../domain/event_document.dart';
import '../domain/event.dart';

final calendarFormatState = StateProvider<CalendarFormat>((ref) => CalendarFormat.month);

final focusedDayProvider = StateNotifierProvider<FocusedDayState, DateTime>(
        (ref) {
          return FocusedDayState();
        }
);
class FocusedDayState extends StateNotifier<DateTime>{
  FocusedDayState() : super(DateTime.now());

  void saveState({required DateTime focusedDay}){
    DateTime day = DateTime(focusedDay.year,focusedDay.month,focusedDay.day);
    state = day;
  }

}

// 該当月のイベント情報のStreamを提供する
final personalEvents = StreamProvider.autoDispose.family<List<EventDocument>, String>(
        (ref, calendarMonth) {
          //final month = ref.watch(calendarMonth);
          var personalEvents = ref.read(eventRepositories).getEvent(calendarMonth);
          return personalEvents;
        });

// 該当月のイベント情報を取得、監視するクラスのプロバイダー
final personalEventList = StateNotifierProvider.autoDispose.family<PersonalEventListController, Map<dynamic, dynamic>, String>(
        (ref, calendarMonth) {
          final events = ref.watch(personalEvents(calendarMonth));
          return PersonalEventListController(ref, events, calendarMonth);
        }
);

class PersonalEventListController extends StateNotifier<Map<dynamic, dynamic>>{
  Ref ref;
  AsyncValue<List<EventDocument>> events;
  String calendarMonth;

  PersonalEventListController(this.ref, this.events, this.calendarMonth) : super({}){
    Map<DateTime, List<EventDocument>> eventsDisplay = {};
    // final events = ref.watch(personalEvents(calendarMonth));
    events.whenData((value){
      eventsDisplay = changeFormat(value);
      eventsDisplay = sortEventList(eventsDisplay);
      state = eventsDisplay;
    });
  }

  Map<DateTime, List<EventDocument>> changeFormat(List<EventDocument> events){
    // final sampleMap = {
    //   DateTime.utc(2024, 2, 22): ['firstEvent', 'secondEvent'],
    //   DateTime.utc(2024, 2, 23): ['thirdEvent', 'fourthEvent']
    // };
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
final eventStream = StateNotifierProvider<EventStream, List<dynamic>>(
        (ref) {
          DateTime today = DateTime.now();
          String month = '${today.year}年${today.month}月';
          String nextMonth = '${today.year}年${today.month + 1}月';
          return EventStream([personalEventList(month), personalEventList(nextMonth)]);
    }
);

class EventStream extends StateNotifier<List<dynamic>>{
  List<dynamic> streamList;
  EventStream(this.streamList) : super(streamList);

  void addStream(dynamic stream){
    state = [...state, stream];
  }

}
//
// // 取得した月の全イベントを格納するクラスを提供する
// final allEventList = StateNotifierProvider<AllEventList, Map<DateTime, List<EventDocument>>>(
//         (ref) {
//       return AllEventList();
//     }
// );
//
// class AllEventList extends StateNotifier<Map<DateTime, List<EventDocument>>>{
//   AllEventList() : super({});
//
//   void addEvent(Map<DateTime, List<EventDocument>> eventMap){
//     state = {...state, ...eventMap};
//   }
//
// }