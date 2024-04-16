import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../application/datetime_format.dart';
import '../../../application/event_list_provider.dart';
import '../../../data/personal_event_repositories.dart';
import 'component/list_widget.dart';

class PersonalEventList extends ConsumerWidget{
  final DateTime focusedDay;
  const PersonalEventList(this.focusedDay, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref){
    final repositories = ref.read(eventRepositories);
    final calendarFormat = ref.read(calendarFormatState.notifier);
    final focusedDayState = ref.read(focusedDayProvider.notifier);

    DateTimeFormat dateFormat = ref.read(dateTimeFormatClass(focusedDay));
    String date = dateFormat.dateJaFormat();
    String calendarMonth = dateFormat.getCalendarMonth();

    Map eventList = ref.read(personalEventList(calendarMonth));
    List eventOnDate = eventList[focusedDay] ?? [];

    return ListWidget(repositories, calendarFormat, focusedDayState, date, eventOnDate, focusedDay);
  }
}