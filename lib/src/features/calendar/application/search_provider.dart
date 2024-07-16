
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_calendar/src/features/calendar/domain/search_page.dart';

import '../../search_value/data/search_value_repositories.dart';
import '../data/calendar_repositories.dart';
import '../domain/calendar_document.dart';

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


//検索ページの表示制御
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
}