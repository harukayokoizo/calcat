import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/personal_event_repositories.dart';
import '../domain/personal_event.dart';

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
    final Map eventList = {};
    for(int i = 0; i < events.length; i++){
      DateTime? from = events[i].from;
      var date = DateTime.utc(from!.year, from.month, from.day);
      eventList.addAll({date : [events[i]]});
    }
    return eventList;
  }


}