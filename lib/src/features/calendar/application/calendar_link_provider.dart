import 'package:flutter_riverpod/flutter_riverpod.dart';

final calendarLinkProvider = StateNotifierProvider.autoDispose.family<CalendarLink, Map<String,String?>, Map<String,String?>?>(
      (ref, calendarLink){
        final link = calendarLink ?? {'url': null, 'name': null};
        return CalendarLink(link);
      },
);

class CalendarLink extends StateNotifier<Map<String,String?>>{
  Map<String,String?> calendarLink;
  CalendarLink(this.calendarLink) : super(calendarLink);

  void saveUrl(String url){
    state = {'url': url, 'name': state['name']};
  }

  void saveName(String name){
    state = {'url': state['url'], 'name': name};
  }
}