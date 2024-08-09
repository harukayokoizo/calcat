import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_calendar/src/features/event/presentation/event/registration/date_form.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../application/event_provider.dart';
import '../../../domain/event.dart';
import '../../../domain/event_initial_time.dart';
import 'calendar_time_form.dart';

class EventCalendarForm extends ConsumerStatefulWidget{
  final Event event;
  final dynamic repositories;
  final List<DateTime> sameEvents;
  final EventInitialTime initialTime;
  const EventCalendarForm(this.event, this.repositories, this.sameEvents, this.initialTime, {super.key});

  @override
  ConsumerState<EventCalendarForm> createState() => EventCalendarFormState();
}

class EventCalendarFormState extends ConsumerState<EventCalendarForm>{
  late final Event event;
  late final dynamic repositories;
  late final List<DateTime> sameEvents;
  late final EventInitialTime initialTime;
  DateTime focusedDay = DateTime.now();

  @override
  void initState() {
    super.initState();
    event = widget.event;
    repositories = widget.repositories;
    sameEvents = widget.sameEvents;
    initialTime = widget.initialTime;
  }
  @override
  Widget build(BuildContext context) {
    final selectedDays = ref.watch(selectedDaysProvider(sameEvents));
    return LayoutBuilder(
      builder: (context,  constraints) {
        return Column(
          children: [
            SizedBox(
              height: constraints.maxHeight * 0.8,
              child: TableCalendar(
                firstDay: DateTime.utc(2024, 01, 01),
                lastDay: DateTime.utc(2050, 12, 31),
                focusedDay: focusedDay,
                headerVisible: true,
                eventFormCalendar: true,
                displayWeekday: true,
                // daysOfWeekHeight: 10,
                dayHeight : constraints.maxHeight,
                rowHeight: constraints.maxHeight * 0.8 / 7.0,
                //shouldFillViewport: true,
                //availableGestures: AvailableGestures.verticalSwipe,
                locale: 'ja_JP',
                calendarFormat: CalendarFormat.month,
                availableCalendarFormats: const {
                  CalendarFormat.month: 'Month',
                },
                calendarStyle : const CalendarStyle( // 週末の日付の色 (土曜と日曜の列)
                  weekendTextStyle : TextStyle(color : Color(0xFF4169e1)), // 今日のハイライト色
                  todayDecoration : BoxDecoration(
                    color : Colors.grey,
                    shape : BoxShape.circle,
                  ), // 選択した日のハイライト色
                  selectedDecoration : BoxDecoration(
                    color : Color(0xFF4169e1),
                    shape : BoxShape.circle,
                  ),
                ),
                selectedDayPredicate: (day) => selectedDays.contains(day),
                //カレンダーがタップするたびにコールされる
                onDaySelected: (selectedDay, focusedDay) {
                  ref.read(selectedDaysProvider(sameEvents).notifier).checkSelectedDay(selectedDay);
                },
                onPageChanged: (value) {
                  setState(() {
                    focusedDay = value;
                  });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: SizedBox(
                  // height: constraint.maxHeight * 0.1,
                  child: CalendarTimeSettingFormat(event, initialTime),
              ),
            ),
            // SizedBox(height: 30,)
          ],
        );
      }
    );
  }
}