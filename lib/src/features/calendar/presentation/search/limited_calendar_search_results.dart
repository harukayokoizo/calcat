import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_calendar/src/features/calendar/presentation/search/searched_calendar_content.dart';

import '../../application/search_provider.dart';
import '../../domain/calendar_document.dart';

class LimitedCalendarSearchResults extends ConsumerWidget{
  final List<CalendarDocument> calendar;
  const LimitedCalendarSearchResults(this.calendar, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref){
    if(calendar.isNotEmpty) {
      return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              ref.read(resultPage.notifier).resultPage(false);
            },
            icon: const Icon(Icons.arrow_back),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: Column(
            children: [
              for(CalendarDocument calendarDoc in calendar)
                SearchedCalendarContent(calendarDoc)
            ],
          ),
        ),
      );
    }else{
      return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              ref.read(resultPage.notifier).resultPage(false);
            },
            icon: const Icon(Icons.arrow_back),
          ),
        ),
        body: const Center(
          child: Text(
            '検索結果はありません。',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20
            ),
          ),
        ),
      );
    }
  }

}