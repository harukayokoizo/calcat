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
  late final ValueNotifier<DateTime> _focusedDay;

  @override
  void initState() {
    super.initState();
    _focusedDay = ValueNotifier(DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double deviceHeight = MediaQuery.of(context).size.height;
    final events = ref.watch(personalEventList);
    print(events);
    const week = ['日', '月', '火', '水', '木', '金', '土'];
    return Scaffold(
      appBar: AppBar(
        elevation: 2.0,
        centerTitle: true,
        title: ValueListenableBuilder<DateTime>(
        valueListenable: _focusedDay,
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
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            TableCalendar(
              firstDay: DateTime.utc(2024,01,01),
              lastDay: DateTime.utc(2050,12,31),
              focusedDay: DateTime.now(),
              headerVisible: false,
              rowHeight: 90,
              //availableGestures: AvailableGestures.verticalSwipe,
              locale: 'ja_JP',
              eventLoader: (date){
                return events[date] ?? [];
              },
              //カレンダーがタップするたびにコールされる
              onDaySelected: (selectedDay, focusedDay) {

              },
              onPageChanged: (value){
                _focusedDay.value = value;
              }
            ),
            Container(height: 100,),
            Container(height: 100,)
          ],
        ),
      ),
    );
  }
}