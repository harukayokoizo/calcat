import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:table_calendar/table_calendar.dart';

import '../application/event_list_provider.dart';

class PersonalCalendarPage extends ConsumerStatefulWidget{
  const PersonalCalendarPage({super.key});

  @override
  ConsumerState createState() => PersonalCalendarPageState();

}

class PersonalCalendarPageState extends ConsumerState{
  GlobalKey itemKey = GlobalKey();
  late final ValueNotifier<DateTime> _focusedDayValue;
  late CalendarFormat _calendarFormat;

  @override
  void initState() {
    super.initState();
    _calendarFormat = CalendarFormat.month;
    _focusedDayValue = ValueNotifier(DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    var focusedDay = ref.watch(focusedDayProvider);
    var calendarFormat = ref.watch(calendarFormatState);
    const week = ['日', '月', '火', '水', '木', '金', '土'];
    final events = ref.watch(personalEventList);
    //print(events);

    return Scaffold(
      key: itemKey,
      appBar: AppBar(
        elevation: 2.0,
        centerTitle: true,
        title: ValueListenableBuilder<DateTime>(
          valueListenable: _focusedDayValue,
          builder: (context, value, _) {
            String title = '${value.year}年${value.month}月';
            return Text(title);
          }),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(30.0),
          child: Row(
            children: [
              for(int i=0; i<7; i++)
              Expanded(
                child: Align(
                    alignment: Alignment.center,
                    child: Text(week[i])),
              ),
            ],
          ),
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return TableCalendar(
            firstDay: DateTime.utc(2024,01,01),
            lastDay: DateTime.utc(2050,12,31),
            focusedDay: focusedDay,
            headerVisible: false,
            rowHeight: constraints.maxHeight / 6.0,
            //shouldFillViewport: true,
            //availableGestures: AvailableGestures.verticalSwipe,
            locale: 'ja_JP',
            calendarFormat: calendarFormat,
            eventLoader: (date){
              return events[date] ?? [];
            },
            //カレンダーがタップするたびにコールされる
            onDaySelected: (selectedDay, focusedDay) {
              if(_calendarFormat == CalendarFormat.month){
                ref.read(calendarFormatState.notifier).state = CalendarFormat.twoWeeks;
                ref.read(focusedDayProvider.notifier).saveState(focusedDay: selectedDay);
              }else{
                ref.read(focusedDayProvider.notifier).saveState(focusedDay: selectedDay);
              }
            },
            onPageChanged: (value){
              _focusedDayValue.value = value;
              ref.read(focusedDayProvider.notifier).saveState(focusedDay: value);
            },
          );
        }
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //   // ignore: invalid_use_of_protected_member
      //   items: const [
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.search),
      //       label: 'Search',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.star),
      //       label: 'Calendar',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.calendar_month),
      //       label: 'My Calendar',
      //     ),
      //   ],
      // ),
    );
  }
}