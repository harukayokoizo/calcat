
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
}