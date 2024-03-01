import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_calendar/src/features/personal_event/application/personal_eventlist_provider.dart';

import '../domain/personal_event.dart';

final personalEventFormStateProvider = StateNotifierProvider.autoDispose<PersonalEventFormState, PersonalEvent>(
        (ref){
          final DateTime focusedDay = ref.read(focusedDayProvider);
          return PersonalEventFormState(focusedDay);
        }
);

class PersonalEventFormState extends StateNotifier<PersonalEvent>{
  DateTime focusedDay;
  PersonalEventFormState(this.focusedDay) : super(
      PersonalEvent(
        uid: null,
        title: null,
        event: null,
        image: null,
        color: null,
        isAllDay: true,
        from: focusedDay,
        to: focusedDay,
        sameEventId: null,
        number: null
      )
  );

  void saveState(PersonalEvent event){
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

}