
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/calendar_repositories.dart';
import '../domain/calendar_document.dart';

final focusState = StateNotifierProvider<FocusSwitch, bool>(
        (ref) => FocusSwitch()
);

class FocusSwitch extends StateNotifier<bool>{
  FocusSwitch() : super(false);

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

final textControllerProvider = StateNotifierProvider.autoDispose<TextController, bool>(
        (ref) => TextController()
);

class TextController extends StateNotifier<bool>{
  TextController() : super(false);

  void switchState(bool value){
    state = value;
  }
}
