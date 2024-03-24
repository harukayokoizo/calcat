import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:table_calendar/table_calendar.dart';


import '../../../../application/event_list_provider.dart';
import '../../../../domain/calendar_document.dart';
import 'detail/calendar_detail.dart';

class PublicCalendarPage extends ConsumerWidget{
  PublicCalendarPage(this.calendarDoc, {super.key});
  CalendarDocument calendarDoc;
  GlobalKey itemKey = GlobalKey();
  late final ValueNotifier<DateTime> _focusedDayValue = ValueNotifier(DateTime.now());
  late final CalendarFormat _calendarFormat = CalendarFormat.month;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final String calendarDocId = calendarDoc.docId!;
    var focusedDay = ref.watch(publicFocusedDay);
    var calendarFormat = ref.watch(publicCalendarFormat);
    const week = ['日', '月', '火', '水', '木', '金', '土'];
    final events = ref.watch(publicEventList(calendarDocId));
    Image imagePath = Image.asset('images/no_image.png',fit: BoxFit.cover,);
    if(calendarDoc.calendar!.image != null) {
      imagePath = Image.network(calendarDoc.calendar!.image!);
    }
    var barSize = AppBar().preferredSize.height;
    print(barSize);

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
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: InkWell(
              onTap: (){
                showCupertinoModalPopup(
                    context: context,
                    builder: (BuildContext context) => CalendarDetail(calendarDoc)
                );
              },
              child: Container(
                width: barSize,
                clipBehavior: Clip.hardEdge,
                decoration: const BoxDecoration(
                  color: Colors.grey,
                  shape: BoxShape.circle,
                ),
                child: FittedBox(
                    fit: BoxFit.cover,
                    child: imagePath
                ),
              ),
            ),
          ),
        ],
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
              publicCalendar: true,
              calendarDocId: calendarDocId,
              firstDay: DateTime.utc(2024,01,01),
              lastDay: DateTime.utc(2050,12,31),
              focusedDay: focusedDay,
              headerVisible: false,
              rowHeight: constraints.maxHeight / 6.0,
              locale: 'ja_JP',
              calendarFormat: calendarFormat,
              eventLoader: (date){
                return events[date] ?? [];
              },
              //カレンダーがタップするたびにコールされる
              onDaySelected: (selectedDay, focusedDay) {
                if(_calendarFormat == CalendarFormat.month){
                  ref.read(publicCalendarFormat.notifier).state = CalendarFormat.twoWeeks;
                  ref.read(publicFocusedDay.notifier).saveState(focusedDay: selectedDay);
                }else{
                  ref.read(publicFocusedDay.notifier).saveState(focusedDay: selectedDay);
                }
              },
              onPageChanged: (value){
                _focusedDayValue.value = value;
                ref.read(publicFocusedDay.notifier).saveState(focusedDay: value);
              },
            );
          }
      ),
    );
  }
}