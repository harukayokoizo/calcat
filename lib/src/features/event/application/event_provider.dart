import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_calendar/src/features/event/application/event_list_provider.dart';

import '../../../common_widgets/application/common_provider.dart';
import '../data/personal_event_repositories.dart';
import '../domain/event_document.dart';
import '../domain/event.dart';
import '../domain/event_initial_time.dart';

final selectedDateTimeProvider = StateNotifierProvider.autoDispose.family<SelectedDateTime, Map<String, int>, EventInitialTime>(
        (ref, initialTime){
          Map<String,int> time = initialTime.initialTime;
          return SelectedDateTime(time);
        }
);

class SelectedDateTime extends StateNotifier<Map<String, int>> {
  final Map<String, int> time;
  SelectedDateTime(this.time) : super(time);

  void saveState(int pickedHour, int pickedMinutes, int fromOrTo){
    int fromHour = state['fromHour']!;
    int fromMinutes = state['fromMinutes']!;
    int toHour = state['toHour']!;
    int toMinutes = state['toMinutes']!;
    if(fromOrTo == 0){
      if(pickedHour > toHour){
        //From to両方変更
        saveFromTo(pickedHour, pickedMinutes);
      }else if(pickedHour < toHour){
        //Fromだけ変更
        saveOnlyFrom(pickedHour, pickedMinutes, toHour, toMinutes);
      }else{
        if(pickedMinutes > toMinutes){
          //From to両方変更
          saveFromTo(pickedHour, pickedMinutes);
        }else if(pickedMinutes < toMinutes){
          //Fromだけ変更
          saveOnlyFrom(pickedHour, pickedMinutes, toHour, toMinutes);
        }else{
          //Fromだけ変更
          saveOnlyFrom(pickedHour, pickedMinutes, toHour, toMinutes);
        }
      }
    }else{
      if(pickedHour > fromHour){
        //toだけ変更
        saveOnlyTo(pickedHour, pickedMinutes, fromHour, fromMinutes);
      }else if(pickedHour < fromHour){
        // 何もしない
      }else{
        if(pickedMinutes > fromMinutes){
          //toだけ変更
          saveOnlyTo(pickedHour, pickedMinutes, fromHour, fromMinutes);
        }else if(pickedMinutes < toMinutes){
          // 何もしない
        }else{
          //toだけ変更
          saveOnlyTo(pickedHour, pickedMinutes, fromHour, fromMinutes);
        }
      }
    }
  }

  void saveOnlyFrom(int pickedHour, int pickedMinutes, int toHour, int toMinutes,){
    state = {'fromHour' : pickedHour, 'fromMinutes' : pickedMinutes, 'toHour' : toHour, 'toMinutes' : toMinutes,};
  }

  void saveFromTo(int pickedHour, int pickedMinutes,){
    state = {'fromHour' : pickedHour, 'fromMinutes' : pickedMinutes, 'toHour' : pickedHour, 'toMinutes' : pickedMinutes,};
  }

  void saveOnlyTo(int pickedHour, int pickedMinutes, int fromHour, int fromMinutes,){
    state = {'fromHour' : fromHour, 'fromMinutes' : fromMinutes, 'toHour' : pickedHour, 'toMinutes' : pickedMinutes,};
  }
}


final selectedDaysProvider = StateNotifierProvider.autoDispose.family<SelectedDays, List<DateTime>, List<DateTime>>(
    (ref, sameEvents){
      return SelectedDays(sameEvents);
    }
);

class SelectedDays extends StateNotifier<List<DateTime>>{
  final List<DateTime> sameEvents;
  SelectedDays(this.sameEvents) : super(sameEvents);

  void checkSelectedDay(DateTime date){
    if (state.contains(date)) {
      removeDate(date);
    } else {
      addDate(date);
    }
  }

  void addDate(DateTime date) {
    state = [...state, date];
  }

  void removeDate(DateTime date) {
    state = state.where((dateState) => dateState.compareTo(date) != 0).toList();
  }
}

final eventFormStateProvider = StateNotifierProvider.autoDispose.family<EventFormState, Event, Event>(
        (ref, event){
          return EventFormState(ref, event);
        }
);

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

  void changeEvent(String value){
    String? overview;
    if(value.isNotEmpty){
      overview = value;
    }
    final event = state.copyWith(overview: overview);
    state = event;
  }

  void changeColor(int color){
    final event = state.copyWith(color: color);
    state = event;
  }

  void changeUrl(String value){
    String? url;
    if(value.isNotEmpty){
      url = value;
    }
    final event = state.copyWith(url: url);
    state = event;
  }

  void changeLocation(String value){
    String? location;
    if(value.isNotEmpty){
      location = value;
    }
    final event = state.copyWith(location: location);
    state = event;
  }

  // void changeNotification(List<int> notification){
  //   notification.sort((a,b)=> a.compareTo(b));
  //   final event = state.copyWith(notification: notification);
  //   state = event;
  // }

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

    if (state.to!.isAfter(saveFromDate) || state.to!.isAtSameMomentAs(selectedDateTime)) {
      event = state.copyWith(from: saveFromDate);
    }else{
      event = state.copyWith(from: saveFromDate, to: saveFromDate);
    }

    state = event;
  }

  void changeOnlyToDate(DateTime selectedDate){
    final DateTime selectedDateTime = DateTime(selectedDate.year, selectedDate.month, selectedDate.day, selectedDate.hour, selectedDate.minute);
    final DateTime saveToDate = DateTime(selectedDate.year, selectedDate.month, selectedDate.day, state.to!.hour, state.to!.minute);

    if(state.from!.isBefore(saveToDate) || state.from!.isAtSameMomentAs(selectedDateTime)) {
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

  /*予定作成画面の保存ボタンを押下時の処理*/
  void createEvent(dynamic repositories, bool newReg, List<DateTime> sameEvents, EventInitialTime initialTime){
    try {
      List<Map<String, dynamic>> events = saveDataList(
          newReg, sameEvents, initialTime);
      repositories.createEvent(events);
    }catch (e){
      throw e.toString();
    }
  }

  /*予定編集画面の保存ボタンを押下時の処理*/
  void updateEvent(int value, EventDocument eventDoc, dynamic repositories, bool newReg, List<DateTime> sameEvents, EventInitialTime initialTime) async{
    try {
      List<Map<String, dynamic>> events = saveDataList(newReg, sameEvents, initialTime);
      if (value == 0) {
        //繰り返しがないイベント
        if (state.repeat == 0) {
          repositories.updateEvent(events.first, eventDoc.docId!);
        } else {
          repositories.deleteAndUpdateEvent([eventDoc.docId!], events);
        }
      } else if (value == 1) {
        //繰り返しはあるが、特定の予定のみを更新する場合
        repositories.updateEvent(events.first, eventDoc.docId!);
      } else if (value == 2) {
        //繰り返しがあり、かつ定期的な予定を更新する場合
        //sameEventIdが同じのイベントをすべて取得する
        List deleteEvents = await repositories.getSameEvent(state.sameEventId!);
        repositories.deleteAndUpdateEvent(deleteEvents, events);
      }
    }catch (e){
      throw e.toString();
    }

  }

  List<Map<String, dynamic>> saveDataList(bool newReg, List<DateTime> sameEvents, EventInitialTime initialTime) {
    DateTime createdAt;
    DateTime updatedAt;
    DateTime from;
    DateTime to;
    String calendarMonth;
    try {
      if (newReg) {
        createdAt = DateTime.now();
        updatedAt = DateTime.now();
      } else {
        createdAt = state.createdAt ?? DateTime.now();
        updatedAt = DateTime.now();
      }
      Map<String, dynamic> data = {
        'uid': state.uid,
        'title': state.title,
        'overview': state.overview,
        'image': state.image,
        'color': state.color,
        'url': state.url,
        'location': state.location,
        'isAllDay': state.isAllDay,
        'from': null,
        'to': null,
        'repeat': state.repeat,
        'endDate': state.endDate,
        'sameEventId': state.sameEventId,
        'number': state.number,
        'calendarId': state.calendarId,
        'notificationExist': state.notificationExist,
        'calendarMonth': null,
        'createdAt': createdAt,
        'updatedAt': updatedAt,
      };

      List<Map<String, dynamic>> events = [];

      if (state.repeat == 0) {
        //通常の場合
        from = DateTime(state.from!.year, state.from!.month, state.from!.day,
            state.from!.hour, state.from!.minute);
        to = DateTime(
            state.to!.year, state.to!.month, state.to!.day, state.to!.hour,
            state.to!.minute);
        calendarMonth = '${state.from!.year}年${state.from!.month}月';
        data['from'] = from;
        data['to'] = to;
        data['calendarMonth'] = calendarMonth;
        events = [data];
      } else {
        //まとめて作成の場合
        final selectedDays = ref.read(selectedDaysProvider(sameEvents));
        final time = ref.read(selectedDateTimeProvider(initialTime).notifier).state;
        if (selectedDays.isNotEmpty) {
          for (DateTime day in selectedDays) {
            from = day;
            to = day;
            Map<String, dynamic> newData = Map.of(data);
            calendarMonth = '${day.year}年${day.month}月';
            if (!state.isAllDay!) {
              from = DateTime(day.year, day.month, day.day, time['fromHour']!,
                  time['fromMinutes']!);
              to = DateTime(day.year, day.month, day.day, time['toHour']!,
                  time['toMinutes']!);
            }
            newData['from'] = from;
            newData['to'] = to;
            newData['calendarMonth'] = calendarMonth;
            events.add(newData);
          }
        }else{
          throw '一つ以上日付を選択してください';
        }
      }

      // List<Map<String, dynamic>> events = [data];
      // int days = state.repeat == 1 ? 1 : state.repeat == 2 ? 7 : final times = ref.watch(selectedDateTimeProvider);0;
      //
      // if(state.repeat != 0){
      //   DateTime endDate = state.endDate!.add(const Duration(days: 1));
      //   from = from.add(Duration(days: days));
      //   to = to.add(Duration(days: days));
      //
      //   while(from.isBefore(endDate)){
      //     Map<String, dynamic> newData = Map.of(data);
      //     calendarMonth = '${from.year}年${from.month}月';
      //     newData['from'] = from;
      //     newData['to'] = to;
      //     newData['calendarMonth'] = calendarMonth;
      //     events.add(newData);
      //     from = from.add(Duration(days: days));
      //     to = to.add(Duration(days: days));
      //   }
      // }

      return events;
    }catch (e){
      throw e.toString();
    }
  }

}