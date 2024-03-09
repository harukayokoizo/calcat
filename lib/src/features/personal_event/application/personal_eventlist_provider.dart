import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:table_calendar/table_calendar.dart';

import '../data/personal_event_repositories.dart';
import '../domain/event_document.dart';
import '../domain/personal_event.dart';

final calendarFormatState = StateProvider<CalendarFormat>((ref) => CalendarFormat.month);

final focusedDayProvider = StateNotifierProvider<FocusedDayState, DateTime>(
        (ref) {
          return FocusedDayState();
        }
);
class FocusedDayState extends StateNotifier<DateTime>{
  FocusedDayState() : super(DateTime.now());

  void saveState({required DateTime focusedDay}){
    state = focusedDay;
  }

}
final personalEvents = StreamProvider<List<EventDocument>>(
        (ref) {
          var personalEvents = ref.read(personalEventRepositories).getEvent();
          return personalEvents;
        });

final personalEventList = StateNotifierProvider.autoDispose<PersonalEventListController, Map<dynamic, dynamic>>(
        (ref) {
          //List<PersonalEvent> events = ref.watch(personalEvents);
          return PersonalEventListController(ref);
        }
);

class PersonalEventListController extends StateNotifier<Map<dynamic, dynamic>>{
  Ref ref;
  //List<PersonalEvent> personalEvents;
  PersonalEventListController(this.ref) : super({}){
    Map eventsDisplay = {};
    final events = ref.watch(personalEvents);
    events.whenData((value){
      eventsDisplay = changeFormat(value);
      state = eventsDisplay;
    });
  }

  Map changeFormat(List<EventDocument> events){
    // final sampleMap = {
    //   DateTime.utc(2024, 2, 22): ['firstEvent', 'secondEvent'],
    //   DateTime.utc(2024, 2, 23): ['thirdEvent', 'fourthEvent']
    // };
    final Map eventList = {};
    for(final EventDocument eventDoc in events){
      PersonalEvent event = eventDoc.event!;
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
        // do{
        // } while(to.difference(from).inDays == i);
      }

      //eventListにMap<DateTime, List<PersonalEvent>>を追加する
      for(var date in keyDate){
        //eventListにdateのkeyが存在するかチェックする
        var containDate = eventList.containsKey(date);
        if(containDate){
          List value = eventList[date];
          value.add(eventDoc);
          eventList[date] = value;
        }else{
          eventList.addAll({date : [eventDoc]});
        }
      }
    }
    print(eventList);
    return eventList;
  }


}