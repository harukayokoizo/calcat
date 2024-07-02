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
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back),
          ),
          title: const Text('検索結果'),
        ),
        body: Column(
          children: [
            for(CalendarDocument calendarDoc in calendar)
              SearchedCalendarContent(calendarDoc)
          ],
        ),
      );
    }else{
      return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back),
          ),
        ),
        body: const Padding(
          padding: EdgeInsets.only(bottom: 50.0),
          child: Center(
            child: Text(
              '検索結果はありません。',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20
              ),
            ),
          ),
        ),
      );
    }
  }

}