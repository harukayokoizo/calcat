import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_calendar/src/features/personal_event/application/personal_eventlist_provider.dart';

import '../../../common_widgets/application/common_provider.dart';
import '../data/personal_event_repositories.dart';
import '../domain/personal_event.dart';

final personalEventFormStateProvider = StateNotifierProvider.autoDispose<PersonalEventFormState, PersonalEvent>(
        (ref){
          final user = ref.read(currentUser);
          final DateTime focusedDay = ref.read(focusedDayProvider);
          return PersonalEventFormState(ref, user!.uid, focusedDay);
        }
);

class PersonalEventFormState extends StateNotifier<PersonalEvent>{
  Ref ref;
  String uid;
  DateTime focusedDay;
  PersonalEventFormState(this.ref, this.uid, this.focusedDay) : super(
      PersonalEvent(
        uid: uid,
        title: null,
        event: null,
        image: null,
        color: 8,
        isAllDay: true,
        from: focusedDay,
        to: focusedDay,
        notification: [],
        repeat: 0,
        endDate: null,
        sameEventId: null,
        number: null
      )
  );

  // void saveState(PersonalEvent event){
  //   state = event;
  // }

  void changeTitle(String title){
    final event = state.copyWith(title: title);
    state = event;
  }

  void changeEvent(String overview){
    final event = state.copyWith(event: overview);
    state = event;
  }

  void changeColor(int color){
    final event = state.copyWith(color: color);
    state = event;
  }

  void changeNotification(List<int> notification){
    final event = state.copyWith(notification: notification);
    state = event;
  }

  void changeRepeatEndDate(DateTime endDate){
    final event = state.copyWith(endDate: endDate);
    state = event;
  }

  void changeRepeat(int repeat){
    final event = state.copyWith(repeat: repeat);
    state = event;
  }

  void changeAllDay(bool isAllDay){
    final newFrom = DateTime(state.from!.year,state.from!.month,state.from!.day);
    final newTo = DateTime(state.to!.year,state.to!.month,state.to!.day);
    PersonalEvent event = state.copyWith(isAllDay: isAllDay, from: newFrom, to: newTo);
    state = event;
  }

  void saveFromDate(DateTime selectedDate){
    PersonalEvent event;
    final DateTime onlyDate = DateTime(selectedDate.year, selectedDate.month, selectedDate.day);

    if (state.to!.isAfter(selectedDate) || state.to!.isAtSameMomentAs(onlyDate)) {
      event = state.copyWith(from: selectedDate);
    }else{
      event = state.copyWith(from: selectedDate, to: selectedDate);
    }

    state = event;
  }

  void saveToDate(DateTime selectedDate){
    final DateTime onlyDate = DateTime(selectedDate.year, selectedDate.month, selectedDate.day);

    if (state.from!.isBefore(selectedDate) || state.from!.isAtSameMomentAs(onlyDate)) {
      PersonalEvent event = state.copyWith(to: selectedDate);
      state = event;
    }
  }

  void changeOnlyFromDate(DateTime selectedDate){
    PersonalEvent event;
    final DateTime selectedDateTime = DateTime(selectedDate.year, selectedDate.month, selectedDate.day, selectedDate.hour, selectedDate.minute);
    final DateTime saveFromDate = DateTime(selectedDate.year, selectedDate.month, selectedDate.day, state.from!.hour, state.from!.minute);

    if (state.to!.isAfter(selectedDate) || state.to!.isAtSameMomentAs(selectedDateTime)) {
      event = state.copyWith(from: saveFromDate);
    }else{
      event = state.copyWith(from: saveFromDate, to: saveFromDate);
    }

    state = event;
  }

  void changeOnlyToDate(DateTime selectedDate){
    final DateTime selectedDateTime = DateTime(selectedDate.year, selectedDate.month, selectedDate.day, selectedDate.hour, selectedDate.minute);
    final DateTime saveToDate = DateTime(selectedDate.year, selectedDate.month, selectedDate.day, state.to!.hour, state.to!.minute);

    if(state.from!.isBefore(selectedDate) || state.from!.isAtSameMomentAs(selectedDateTime)) {
      PersonalEvent event = state.copyWith(to: saveToDate);
      state = event;
    }
  }

  void changeFromDate(DateTime selectedDate){
    PersonalEvent event;
    final DateTime dateTime = DateTime(selectedDate.year, selectedDate.month, selectedDate.day, selectedDate.hour, selectedDate.minute);

    if (state.to!.isAfter(selectedDate) || state.to!.isAtSameMomentAs(dateTime)) {
      event = state.copyWith(from: selectedDate);
    }else{
      event = state.copyWith(from: selectedDate, to: selectedDate);
    }

    state = event;
  }

  void changeToDate(DateTime selectedDate){
    final DateTime dateTime = DateTime(selectedDate.year, selectedDate.month, selectedDate.day, selectedDate.hour, selectedDate.minute);

    if (state.from!.isBefore(selectedDate) || state.from!.isAtSameMomentAs(dateTime)) {
      PersonalEvent event = state.copyWith(to: selectedDate);
      state = event;
    }
  }

  void createEvent(){
    DateTime from = DateTime.utc(state.from!.year, state.from!.month, state.from!.day);
    DateTime to = DateTime.utc(state.to!.year, state.to!.month, state.to!.day);
    Map<String, dynamic> data = {
      'uid': state.uid,
      'title': state.title,
      'event': state.event,
      'image': state.image,
      'color': state.color,
      'isAllDay': state.isAllDay,
      'from': state.from,
      'to': state.to,
      'notification': state.notification,
      'repeat': state.repeat,
      'endDate': state.endDate,
      'sameEventId': state.sameEventId,
      'number': state.number,
    };

    List events = [data];
    int days = state.repeat == 1 ? 1 : state.repeat == 2 ? 7 : 0;

    if(state.repeat != 0){
      DateTime endDate = state.endDate!.add(const Duration(days: 1));
      from = from.add(Duration(days: days));
      to = to.add(Duration(days: days));

      while(from.isBefore(endDate)){
        Map<String, dynamic> newData = Map.of(data);
        newData['from'] = from;
        newData['to'] = to;
        events.add(newData);
        from = from.add(Duration(days: days));
        to = to.add(Duration(days: days));
      }
    }

    print(events);
    ref.read(personalEventRepositories).createEvent(events);
  }

}