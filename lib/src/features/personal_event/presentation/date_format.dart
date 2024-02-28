import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:table_calendar/table_calendar.dart';

import '../application/datetime_format.dart';

class DateSettingFormat extends ConsumerWidget{
  final DateTime focusedDay;
  const DateSettingFormat(this.focusedDay, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    DateTimeFormat dateFormat = ref.read(dateTimeFormatClass(focusedDay));
    String weekday = dateFormat.weekday[dateFormat.weekdayNum]!;
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double deviceHeight = MediaQuery.of(context).size.height;
    return Container(
        //height: 100,
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
            ),
            const Expanded(child: SizedBox(),),
            Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CupertinoSwitch(
                    // This bool value toggles the switch.
                    value: true,
                    activeColor: CupertinoColors.activeBlue,
                    onChanged: (bool? value) {
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