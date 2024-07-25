import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../event/application/datetime_format.dart';
import '../../../event/presentation/event/list/component/list_widget.dart';
import '../../application/event_list_provider.dart';
import '../../data/event_repositories.dart';
import '../../domain/calendar_event.dart';
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

    DateTimeFormat dateFormat = ref.read(dateTimeFormatClass(focusedDay));
    String date = dateFormat.dateJaFormat();
    String month = dateFormat.getCalendarMonth();
    CalendarEvent calendarEvent = CalendarEvent(calendarDocId, month);

    Map eventList = ref.read(publicEventList(calendarEvent));
    List eventOnDate = eventList[focusedDay] ?? [];
    eventOnDate.sort((a, b) => a.event!.from!.compareTo(b.event!.from!));
    eventOnDate.sort((a, b) => (a.event!.isAllDay == b.event!.isAllDay ? 0 : (a.event!.isAllDay! ? -1 : 1)));
    eventOnDate.sort((a, b) => ((a.event!.isAllDay! && b.event!.isAllDay!) ? a.event!.createdAt!.compareTo(b.event!.createdAt!) : 0));

    return PublicListWidget(repositories, calendarFormat, focusedDayState, date, eventOnDate, focusedDay, followCalendar, calendarDocId);
  }
}