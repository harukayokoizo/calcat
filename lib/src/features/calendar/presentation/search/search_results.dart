import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../application/search_provider.dart';
import '../../domain/calendar.dart';
import '../../domain/calendar_document.dart';
import '../calendar/list/calendar_content.dart';

class SearchResults extends ConsumerWidget{
  List<CalendarDocument> calendarList;
  SearchResults(this.calendarList, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref){
    return Column(
      children: [
        for(CalendarDocument calendarDoc in calendarList)
          CalendarContent(calendarDoc)
      ],
    );
  }
}