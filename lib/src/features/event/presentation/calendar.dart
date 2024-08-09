import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:share_calendar/src/features/event/presentation/side_menu.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:table_calendar/table_calendar.dart';

import '../application/event_list_provider.dart';
import 'menu.dart';

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
    _calendarFormat = ref.watch(calendarFormatState);
    const week = ['日', '月', '火', '水', '木', '金', '土'];
    Map events = {};
    var extraEventList = ref.watch(eventStream);
    if(extraEventList.isNotEmpty){
      for(var stream in extraEventList){
        final eventList = ref.watch(stream);
        if(eventList.isNotEmpty){
          events.addAll(eventList);
        }
      }
    }

    return Scaffold(
      key: itemKey,
      appBar: AppBar(
        elevation: 2.0,
        centerTitle: true,
        shape: const Border(bottom: BorderSide(width: 0.5, color: Color(0xFFCCCCCC))),
        title: ValueListenableBuilder<DateTime>(
          valueListenable: _focusedDayValue,
          builder: (context, value, _) {
            String title = '${value.year}年${value.month}月';
            return Text(title,
              style: const TextStyle(
                fontWeight: FontWeight.bold
              ),
            );
          }),
        actions: [
          IconButton(
              onPressed: (){
                showCupertinoModalPopup(
                    context: context,
                    builder: (BuildContext context) => const MenuModal()
                );
              },
              icon: const Icon(Icons.menu)
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(20.0),
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
            dayHeight : constraints.maxHeight,
            rowHeight: constraints.maxHeight / 6,
            locale: 'ja_JP',
            calendarFormat: _calendarFormat,
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
              if(focusedDay.isBefore(value)){
                //次月に移動
                String month = '${value.year}年${value.month + 1}月';
                ref.read(eventStream.notifier).addStream(personalEventList(month));
              }else{
                //前月に移動
                String month = '${value.year}年${value.month}月';
                ref.read(eventStream.notifier).addStream(personalEventList(month));
              }
            },
          );
        }
      ),
      // endDrawer: drawerWidget(),
    );
  }
}