import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:table_calendar/table_calendar.dart';

import '../data/personal_event_repositories.dart';
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
final personalEvents = StreamProvider<List<PersonalEvent>>(
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

  Map changeFormat(List<PersonalEvent> events){
    // final sampleMap = {
    //   DateTime.utc(2024, 2, 22): ['firstEvent', 'secondEvent'],
    //   DateTime.utc(2024, 2, 23): ['thirdEvent', 'fourthEvent']
    // };
    final Map eventList = {};
    for(final PersonalEvent event in events){
      List keyDate = [];
      DateTime? from = event.from;
      DateTime? to = event.to;
      from = DateTime.utc(from!.year, from.month, from.day);
      to = DateTime.utc(to!.year, to.month, to.day);
      if(from == to){
        //イベントの開始日と終了日が同じの場合
        keyDate = [from];
      }else{
        do{
          keyDate.add(from);
          from.add(const Duration(days: 1));
        } while(from == to);
      }

      //eventListにMap<DateTime, List<PersonalEvent>>を追加する
      for(var date in keyDate){
        //eventListにdateのkeyが存在するかチェックする
        var containDate = eventList.containsKey(date);
        if(containDate){
          eventList[date].add([event]);
        }else{
          eventList.addAll({from : [event]});
        }
      }
    }
    return eventList;
  }


}