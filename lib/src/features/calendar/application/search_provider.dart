
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/calendar_repositories.dart';
import '../domain/calendar_document.dart';

final searchSwitch = StateNotifierProvider<SearchSwitch, bool>(
        (ref) => SearchSwitch()
);

class SearchSwitch extends StateNotifier<bool>{
  SearchSwitch() : super(false);

  void switchState(bool value){
    state = value;
  }
}

final resultPage = StateNotifierProvider.autoDispose<ResultPageState , bool>(
        (ref) => ResultPageState()
);

class ResultPageState extends StateNotifier<bool>{
  ResultPageState() : super(false);

  void resultPage(bool value){
    state = value;
  }
}

final searchResultsProvider = StateNotifierProvider.autoDispose<SearchResultState, List<CalendarDocument>>(
        (ref) => SearchResultState(ref)
);

class SearchResultState extends StateNotifier<List<CalendarDocument>>{
  Ref ref;
  SearchResultState(this.ref) : super([]);

  Future<void> searchCalendar(String value) async{
    List<CalendarDocument> results = await ref.read(calendarRepositories).searchCalendar(value);
    state = results;
  }

  Future<void> searchLimitedCalendar(String calendarTitle, String password) async{
    List<CalendarDocument> results = await ref.read(calendarRepositories).searchLimitedCalendar(calendarTitle, password);
    state = results;
  }
}

// final limitedCalendarProvider = StateNotifierProvider<LimitedCalendarState, CalendarDocument?>(
//         (ref) => LimitedCalendarState(ref)
// );
//
// class LimitedCalendarState extends StateNotifier<CalendarDocument?>{
//   Ref ref;
//   LimitedCalendarState(this.ref) : super(null);
//
//   void selectCalendar(CalendarDocument? calendarDoc) {
//     state = calendarDoc;
//   }
// }