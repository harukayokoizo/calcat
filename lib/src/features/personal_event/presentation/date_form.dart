import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../application/datetime_format.dart';
import '../application/personal_event_provider.dart';
import '../domain/personal_event.dart';
import 'package:flutter_localizations/flutter_localizations.dart';


class DateSettingFormat extends ConsumerWidget{
  final DateTime focusedDay;
  const DateSettingFormat(this.focusedDay, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final personalEvent = ref.watch(personalEventFormStateProvider);
    // print(personalEvent.to);
    // print(personalEvent.from);

    final double deviceWidth = MediaQuery.of(context).size.width;
    final double deviceHeight = MediaQuery.of(context).size.height;

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
              child: dateFormFormat(context, ref, personalEvent, 0),
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
              child: dateFormFormat(context, ref, personalEvent, 1),
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
                      DateTime from = personalEvent.from!;
                      DateTime to = personalEvent.to!;
                      final newFrom = DateTime(from.year,from.month,from.day);
                      final newTo = DateTime(to.year,to.month,to.day);
                      PersonalEvent event = personalEvent.copyWith(isAllDay: value, from: newFrom, to: newTo);
                      ref.read(personalEventFormStateProvider.notifier).saveState(event);
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

Widget dateFormFormat(BuildContext context, WidgetRef ref, PersonalEvent personalEvent, int fromOrTo){
  // final DateTime from = DateTime(personalEvent.from!.year, personalEvent.from!.month, personalEvent.from!.day);
  // final DateTime to = DateTime(personalEvent.to!.year, personalEvent.to!.month, personalEvent.to!.day);
  // final DateTime fromDateTime = DateTime(personalEvent.from!.year, personalEvent.from!.month, personalEvent.from!.day, personalEvent.from!.hour, personalEvent.from!.minute);
  // final DateTime toDateTime = DateTime(personalEvent.to!.year, personalEvent.to!.month, personalEvent.to!.day, personalEvent.to!.hour, personalEvent.to!.minute);

  //from(開始日時)
  final DateTimeFormat fromDate = ref.read(dateTimeFormatClass(personalEvent.from!));
  final String fromWeekday = fromDate.weekday[fromDate.weekdayNum]!;

  //to(終了日時)
  final DateTimeFormat toDate = ref.read(dateTimeFormatClass(personalEvent.to!));
  final String toWeekday = toDate.weekday[toDate.weekdayNum]!;

  DateTime focusedDay = fromOrTo == 0 ? personalEvent.from! : personalEvent.to!;
  DateTimeFormat dateFormat = fromOrTo == 0 ? fromDate : toDate;
  String weekday = fromOrTo == 0 ? fromWeekday : toWeekday;

  DateFormat hourFormat = DateFormat("HH");
  DateFormat minutesFormat = DateFormat("mm");

  if(personalEvent.isAllDay!){
    return InkWell(
      onTap: ()async{
        final DateTime? picked = await showDatePicker(
          context: context,
          initialDate: focusedDay,
          firstDate: DateTime(2024,1,1),
          lastDate: DateTime(2025,1,1),
          //locale: const Locale('ja', 'JP'),
        );

        if(picked != null) {
          if(fromOrTo == 0){
            ref.read(personalEventFormStateProvider.notifier).saveFromDate(picked);
          }else {
            ref.read(personalEventFormStateProvider.notifier).saveToDate(picked);
          }
        }

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
              fontSize: 18,
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
          onTap: ()async{
            final DateTime? picked = await showDatePicker(
              context: context,
              initialDate: focusedDay,
              firstDate: DateTime(2024,1,1),
              lastDate: DateTime(2025,1,1),
              //locale: const Locale('jp', 'JA'),
            );
            if(picked != null) {
              if(fromOrTo == 0){
                ref.read(personalEventFormStateProvider.notifier).changeOnlyFromDate(picked);
              }else {
                ref.read(personalEventFormStateProvider.notifier).changeOnlyToDate(picked);
              }
            }
          },
          child: Text(
            '${dateFormat.month}月${dateFormat.day}日($weekday曜日)',
            style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 12
            ),
          ),
        ),
        InkWell(
          onTap: ()async{
            final DateTime? picked = await DatePicker.showTimePicker(
                context,
                showTitleActions: true,
                showSecondsColumn: false,
                onChanged: (date) {
                },
                onConfirm: (date) {
                },
                currentTime: focusedDay,
                locale: LocaleType.jp
            );
            if(picked != null) {
              if(fromOrTo == 0){
                ref.read(personalEventFormStateProvider.notifier).changeFromDate(picked);
              }else {
                ref.read(personalEventFormStateProvider.notifier).changeToDate(picked);
              }
            }
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