import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:table_calendar/table_calendar.dart';

import '../application/calendar.dart';
import '../application/personal_event_provider.dart';

class PersonalCalendarPage2 extends ConsumerStatefulWidget{
  const PersonalCalendarPage2({super.key});

  @override
  ConsumerState createState() => PersonalCalendarPage2State();

}

class PersonalCalendarPage2State extends ConsumerState{
  @override
  Widget build(BuildContext context) {
    DateTime _focusedDay = DateTime.now();
    DateTime? _selectedDay;
    return TableCalendar(
      firstDay: DateTime.utc(2024,01,01),
      lastDay: DateTime.utc(2050,12,31),
      focusedDay: DateTime.now(),
      rowHeight: 90,
      availableGestures: AvailableGestures.horizontalSwipe,
      selectedDayPredicate: (day) {
        return isSameDay(_selectedDay, day);
      },
      //カレンダーがタップするたびにコールされる
      onDaySelected: (selectedDay, focusedDay) {
        setState(() {
          _selectedDay = selectedDay;
          _focusedDay = focusedDay; // update `_focusedDay` here as well
        });
      },
    );
  }
}