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
    const week = ['日', '月', '火', '水', '木', '金', '土'];
    late Offset itemPosition = const Offset(0, 0);
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double deviceHeight = MediaQuery.of(context).size.height;
    final events = ref.watch(personalEventList);

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
            //shouldFillViewport: true,
            rowHeight: constraints.maxHeight / 6.0,
            //availableGestures: AvailableGestures.verticalSwipe,
            //locale: 'ja_JP',
            calendarFormat: _calendarFormat,
            eventLoader: (date){
              return events[date] ?? [];
            },
            //カレンダーがタップするたびにコールされる
            onDaySelected: (selectedDay, focusedDay) {
              if(_calendarFormat == CalendarFormat.month){
                setState(() {
                  _calendarFormat = CalendarFormat.twoWeeks;
                  //focusedDay = selectedDay;
                });
                ref.read(focusedDayProvider.notifier).saveState(focusedDay: selectedDay);
              }else{
                setState(() {
                  _calendarFormat = CalendarFormat.month;
                  //focusedDay = DateTime.now();
                });
                ref.read(focusedDayProvider.notifier).saveState(focusedDay: selectedDay);
              }
            },
            onPageChanged: (value){
              _focusedDayValue.value = value;
              ref.read(focusedDayProvider.notifier).saveState(focusedDay: value);
            },
            onFormatChanged: (format){

            },
          );
        }
      ),
    );
  }
}