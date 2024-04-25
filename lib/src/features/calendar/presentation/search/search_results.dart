import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../application/search_provider.dart';
import '../../domain/calendar.dart';
import '../../domain/calendar_document.dart';
import 'searched_calendar_content.dart';

class SearchResults extends ConsumerWidget{
  List<CalendarDocument> calendarList;
  SearchResults(this.calendarList, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref){
    if(calendarList.isNotEmpty) {
      return Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: Column(
          children: [
            for(CalendarDocument calendarDoc in calendarList)
              SearchedCalendarContent(calendarDoc)
          ],
        ),
      );
    }else{
      return const Center(
        child: Text(
          '検索結果はありません。',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20
          ),
        ),
      );
    }
  }
}