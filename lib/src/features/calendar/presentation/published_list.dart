import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../application/calendar_list_provider.dart';
import '../domain/calendar_document.dart';
import 'content/calendar_content.dart';

class PublishedCalendarList extends ConsumerWidget{
  const PublishedCalendarList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final calendar = ref.watch(calendarList);
    return calendar.when(
      error: (err, _) => const SizedBox(), //エラー時
      loading: () => const SizedBox(), //読み込み時
      data: (data) => CalendarList(data), //データ受け取り時
    );
  }
}

class CalendarList extends StatelessWidget{
  List<CalendarDocument> calendarList;

  CalendarList(this.calendarList, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for(CalendarDocument calendarDoc in calendarList)
          CalendarContent(calendarDoc)
      ],
    );
  }

}