import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../application/datetime_format.dart';
import '../../application/personal_event_provider.dart';
import '../../domain/personal_event.dart';
import 'package:flutter_localizations/flutter_localizations.dart';


class EventDateDetail extends ConsumerWidget{
  PersonalEvent personalEvent;
  EventDateDetail(this.personalEvent,{super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
          ],
        )
    );
  }
}

Widget dateFormFormat(BuildContext context, WidgetRef ref, PersonalEvent personalEvent, int fromOrTo){
  //from(開始日時)
  final DateTimeFormat fromDate = ref.read(dateTimeFormatClass(personalEvent.from!));
  final String fromWeekday = fromDate.weekday[fromDate.weekdayNum]!;

  //to(終了日時)
  final DateTimeFormat toDate = ref.read(dateTimeFormatClass(personalEvent.to!));
  final String toWeekday = toDate.weekday[toDate.weekdayNum]!;

  DateTimeFormat dateFormat = fromOrTo == 0 ? fromDate : toDate;
  String weekday = fromOrTo == 0 ? fromWeekday : toWeekday;

  DateFormat hourFormat = DateFormat("HH");
  DateFormat minutesFormat = DateFormat("mm");

  if(personalEvent.isAllDay!){
    return Column(
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
    );
  }else{
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${dateFormat.month}月${dateFormat.day}日($weekday曜日)',
          style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 13
          ),
        ),
        Text(
          '${hourFormat.format(dateFormat.date)}:${minutesFormat.format(dateFormat.date)}',
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

}