import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../personal_event/application/datetime_format.dart';
import '../../../personal_event/presentation/event/list/component/list_widget.dart';
import '../../application/event_list_provider.dart';
import '../../data/event_repositories.dart';
import 'list_widget.dart';

class PublicEventList extends ConsumerWidget{
  final DateTime focusedDay;
  final String calendarDocId;
  final bool followCalendar;
  const PublicEventList(this.focusedDay, this.calendarDocId, this.followCalendar, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref){
    final repositories = ref.read(publicEventRepositories(calendarDocId));
    final calendarFormat = ref.read(publicCalendarFormat.notifier);
    final focusedDayState = ref.read(publicFocusedDay.notifier);
    // final focusedDay = ref.read(publicFocusedDay);

    DateTimeFormat dateFormat = ref.read(dateTimeFormatClass(focusedDay));
    String date = dateFormat.dateJaFormat();

    Map eventList = ref.read(publicEventList(calendarDocId));
    List eventOnDate = eventList[focusedDay] ?? [];

    return PublicListWidget(repositories, calendarFormat, focusedDayState, date, eventOnDate, focusedDay, followCalendar);
  }
}