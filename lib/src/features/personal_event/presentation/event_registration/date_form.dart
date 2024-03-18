import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../application/datetime_format.dart';
import '../../application/event_provider.dart';
import '../../domain/event.dart';
import 'package:flutter_localizations/flutter_localizations.dart';


class DateSettingFormat extends ConsumerWidget{
  Event event;
  DateSettingFormat(this.event, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final personalEvent = ref.watch(eventFormStateProvider(event));
    // print(personalEvent.to);
    // print(personalEvent.from);

    final double deviceWidth = MediaQuery.of(context).size.width;

    return Container(
        width: deviceWidth,
        decoration: const BoxDecoration(
          border: Border(
            //top: BorderSide(color: Colors.grey, width: 1.0),
            bottom: BorderSide(color: Colors.grey, width: 1.0),
          ),
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0, bottom: 10.0),
              child: dateFormFormat(context, ref, personalEvent, 0, event),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 20.0),
              child: Icon(
                Icons.arrow_forward_ios,
                size: 15,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0, bottom: 10.0),
              child: dateFormFormat(context, ref, personalEvent, 1, event),
            ),
            const Expanded(child: SizedBox(),),
            Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CupertinoSwitch(
                    // This bool value toggles the switch.
                    value: personalEvent.isAllDay!,
                    activeColor: CupertinoColors.activeBlue,
                    onChanged: (bool? value) {
                      ref.read(eventFormStateProvider(event).notifier).changeAllDay(value!);
                    },
                  ),
                  const Text(
                    '終日 オン',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w800
                    ),
                  )
                ],
              ),
            ),

          ],
        )
    );
  }
}

Widget dateFormFormat(BuildContext context, WidgetRef ref, Event event, int fromOrTo, Event parameter){
  final DateTime from = DateTime(event.from!.year, event.from!.month, event.from!.day);
  final DateTime to = DateTime(event.to!.year, event.to!.month, event.to!.day);

  //from(開始日時)
  final DateTimeFormat fromDate = ref.read(dateTimeFormatClass(event.from!));
  final String fromWeekday = fromDate.weekday[fromDate.weekdayNum]!;

  //to(終了日時)
  final DateTimeFormat toDate = ref.read(dateTimeFormatClass(event.to!));
  final String toWeekday = toDate.weekday[toDate.weekdayNum]!;

  DateTime focusedDay = fromOrTo == 0 ? event.from! : event.to!;
  DateTimeFormat dateFormat = fromOrTo == 0 ? fromDate : toDate;
  String weekday = fromOrTo == 0 ? fromWeekday : toWeekday;

  DateFormat hourFormat = DateFormat("HH");
  DateFormat minutesFormat = DateFormat("mm");

  if(event.isAllDay!){
    return InkWell(
      onTap: (){
        showDatePicker(
          context: context,
          initialDate: focusedDay,
          firstDate: DateTime(2024,1,1),
          lastDate: DateTime(2050,1,1),
          //locale: const Locale('ja', 'JP'),
        ).then((picked){
          if(picked != null) {
            if(fromOrTo == 0){
              //fromのカレンダー
              if(event.repeat != 0 && !picked.isAtSameMomentAs(to)){
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    backgroundColor: Colors.red,
                    content: Text(
                      '日付をまたぐ行動を繰り返すことはできません。',
                      style: TextStyle(
                        fontSize: 15,
                        //fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                );
              }else{
                ref.read(eventFormStateProvider(parameter).notifier).saveFromDate(picked);
              }
            }else {
              //toのカレンダー
              if(event.repeat != 0 && !picked.isAtSameMomentAs(from)){
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    backgroundColor: Colors.red,
                    content: Text(
                      '日付をまたぐ行動を繰り返すことはできません。',
                      style: TextStyle(
                        fontSize: 15,
                        //fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                );
              }else{
                ref.read(eventFormStateProvider(parameter).notifier).saveToDate(picked);
              }
            }
          }
        });
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$weekday曜日',
            style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15
            ),
          ),
          Text(
            '${dateFormat.month}月${dateFormat.day}日',
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }else{
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: (){
            showDatePicker(
              context: context,
              initialDate: focusedDay,
              firstDate: DateTime(2024,1,1),
              lastDate: DateTime(2050,1,1),
              //locale: const Locale('jp', 'JA'),
            ).then((picked){
              if(picked != null) {
                if(fromOrTo == 0){
                  if(event.repeat != 0 && !picked.isAtSameMomentAs(to)){
                    ref.read(eventFormStateProvider(parameter).notifier).changeOnlyFromDate(picked);
                  }else{
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        backgroundColor: Colors.red,
                        content: Text(
                          '日付をまたぐ行動を繰り返すことはできません。',
                          style: TextStyle(
                            fontSize: 15,
                            //fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                    );
                  }
                }else {
                  if(event.repeat != 0 && !picked.isAtSameMomentAs(from)){
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        backgroundColor: Colors.red,
                        content: Text(
                          '日付をまたぐ行動を繰り返すことはできません。',
                          style: TextStyle(
                            fontSize: 15,
                            //fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                    );
                  }else{
                    ref.read(eventFormStateProvider(parameter).notifier).changeOnlyToDate(picked);
                  }
                }
              }
            });
          },
          child: Text(
            '${dateFormat.month}月${dateFormat.day}日($weekday曜日)',
            style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 13
            ),
          ),
        ),
        InkWell(
          onTap: ()async{
            DatePicker.showTimePicker(
                context,
                showTitleActions: true,
                showSecondsColumn: false,
                onChanged: (date) {
                },
                onConfirm: (date) {
                },
                currentTime: focusedDay,
                locale: LocaleType.jp
            ).then((picked){
              if(picked != null) {
                if(fromOrTo == 0){
                  ref.read(eventFormStateProvider(parameter).notifier).changeFromDate(picked);
                }else {
                  ref.read(eventFormStateProvider(parameter).notifier).changeToDate(picked);
                }
              }
            });
          },
          child: Text(
            '${hourFormat.format(dateFormat.date)}:${minutesFormat.format(dateFormat.date)}',
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

}