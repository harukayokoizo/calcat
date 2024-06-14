
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_calendar/src/features/calendar/domain/search_page.dart';

import '../../search_value/data/search_value_repositories.dart';
import '../data/calendar_repositories.dart';
import '../domain/calendar_document.dart';

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
    await ref.read(searchValueRepositories).operateCollection(value);
    List<CalendarDocument> results = await ref.read(calendarRepositories).searchCalendar(value);
    state = results;
  }

  Future<void> searchLimitedCalendar(String calendarTitle, String password) async{
    List<CalendarDocument> results = await ref.read(calendarRepositories).searchLimitedCalendar(calendarTitle, password);
    state = results;
  }
}

final searchCalendarListProvider = FutureProvider.autoDispose.family<List<CalendarDocument>, String>(
        (ref, value) {
          final searchCalendarList = ref.read(calendarRepositories).searchCalendarList(value);
          return searchCalendarList;
        });

final followRankingListProvider = FutureProvider.autoDispose<List<CalendarDocument>>(
        (ref) {
          final calendarList = ref.read(calendarRepositories).followRankingList();
          return calendarList;
    });







final searchPageProvider = StateNotifierProvider.autoDispose<SearchPageState, SearchPage>(
        (ref){
          return SearchPageState(ref);
        }
);

class SearchPageState extends StateNotifier<SearchPage>{
  Ref ref;
  SearchPageState(this.ref) : super(const SearchPage(result: false, editing: false, text: null));

  void saveState(SearchPage searchState){
    state = searchState;
  }

  void saveResultState(bool result){
    final searchState = state.copyWith(result: result);
    state = searchState;
  }

  void saveEditingState(bool editing) {
    final searchState = state.copyWith(editing: editing);
    state = searchState;
  }

  void saveText(String? text) {
    final searchState = state.copyWith(text: text);
    state = searchState;
  }
}