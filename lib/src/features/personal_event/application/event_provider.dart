import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_calendar/src/features/personal_event/application/eventlist_provider.dart';

import '../../../common_widgets/application/common_provider.dart';
import '../data/personal_event_repositories.dart';
import '../domain/event_document.dart';
import '../domain/event.dart';

final eventFormStateProvider = StateNotifierProvider.autoDispose.family<EventFormState, Event, Event?>(
        (ref, event){
          if(event == null) {
            final user = ref.read(currentUser);
            final DateTime focusedDay = ref.read(focusedDayProvider);
            event = Event(
                uid: user!.uid,
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
            );
          }
          return EventFormState(ref, event);
        }
);

// final personalEventEditFormStateProvider = StateNotifierProvider.autoDispose.family<PersonalEventFormState, PersonalEvent, PersonalEvent>(
//         (ref, event){
//           return PersonalEventFormState(ref, event);
//         }
// );

class EventFormState extends StateNotifier<Event>{
  Ref ref;
  // String uid;
  // DateTime focusedDay;
  Event eventDate;
  EventFormState(this.ref, this.eventDate) : super(eventDate);

  void saveEvent(Event event){
    state = event;
  }

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
    notification.sort((a,b)=> a.compareTo(b));
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

  void resetRepeat(){
    final event = state.copyWith(repeat: 0, endDate: null);
    state = event;
  }

  void changeAllDay(bool isAllDay){
    final newFrom = DateTime(state.from!.year,state.from!.month,state.from!.day);
    final newTo = DateTime(state.to!.year,state.to!.month,state.to!.day);
    Event event = state.copyWith(isAllDay: isAllDay, from: newFrom, to: newTo);
    state = event;
  }

  void saveFromDate(DateTime selectedDate){
    Event event;
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
      Event event = state.copyWith(to: selectedDate);
      state = event;
    }
  }

  void changeOnlyFromDate(DateTime selectedDate){
    Event event;
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
      Event event = state.copyWith(to: saveToDate);
      state = event;
    }
  }

  void changeFromDate(DateTime selectedDate){
    Event event;
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
      Event event = state.copyWith(to: selectedDate);
      state = event;
    }
  }

  void createEvent(){
    List<Map<String, dynamic>> events = saveDataList();
    ref.read(eventRepositories).createEvent(events);
  }

  void updateEvent(int value, EventDocument eventDoc) async{
    List<Map<String, dynamic>> events = saveDataList();
    if(value == 0){
      //繰り返しがないイベント
      if(state.repeat == 0){
        ref.read(eventRepositories).updateEvent(events.first, eventDoc.docId!);
      }else{
        ref.read(eventRepositories).deleteAndUpdateEvent([eventDoc.docId!], events);
      }
    }else if(value == 1){
      //繰り返しはあるが、特定の予定のみを更新する場合
      ref.read(eventRepositories).updateEvent(events.first, eventDoc.docId!);
    }else if(value == 2){
      //繰り返しがあり、かつ定期的な予定を更新する場合
      //sameEventIdが同じのイベントをすべて取得する
      List deleteEvents = await ref.read(eventRepositories).getSameEvent(state.sameEventId!);
      ref.read(eventRepositories).deleteAndUpdateEvent(deleteEvents, events);
    }

  }

  List<Map<String, dynamic>> saveDataList(){
    DateTime from = DateTime(state.from!.year, state.from!.month, state.from!.day, state.from!.hour, state.from!.minute);
    DateTime to = DateTime(state.to!.year, state.to!.month, state.to!.day, state.to!.hour, state.to!.minute);
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

    List<Map<String, dynamic>> events = [data];
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

    return events;
  }

}