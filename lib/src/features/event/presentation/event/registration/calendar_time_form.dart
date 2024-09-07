import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../application/event_provider.dart';
import '../../../domain/event.dart';
import '../../../domain/event_initial_time.dart';

class CalendarTimeSettingFormat extends ConsumerWidget{
  final Event event;
  final EventInitialTime initialTime;
  const CalendarTimeSettingFormat(this.event, this.initialTime, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final personalEvent = ref.watch(eventFormStateProvider(event));
    final double deviceWidth = MediaQuery.of(context).size.width;

    return Container(
        width: deviceWidth,
        decoration: const BoxDecoration(
          border: Border(
            // top: BorderSide(color: Colors.grey, width: 1.0),
            // bottom: BorderSide(color: Colors.grey, width: 1.0),
          ),
        ),
        child: Row(
          children: [
            if(!personalEvent.isAllDay!)
              calendarTime(context, ref, initialTime),
            const Expanded(child: SizedBox(),),
            Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Transform.scale(
                    scale: 0.9,
                    child: CupertinoSwitch(
                      // This bool value toggles the switch.
                      value: personalEvent.isAllDay!,
                      activeColor: CupertinoColors.activeBlue,
                      onChanged: (bool? value) {
                        ref.read(eventFormStateProvider(event).notifier).changeAllDay(value!);
                      },
                    ),
                  ),
                  const Text(
                    '終日 オン',
                    style: TextStyle(
                        fontSize: 10,
                        // fontWeight: FontWeight.w800
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

Widget calendarTime(BuildContext context, WidgetRef ref, EventInitialTime initialTime){
  return Align(
    alignment: Alignment.center,
    child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: SizedBox(
        child: Row(
          children: [
            Padding(
                padding: const EdgeInsets.only(left: 10, right: 20),
                child: calendarTimeForm(context, ref, 0, initialTime),
            ),
            const Text(
              '-',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: calendarTimeForm(context, ref, 1, initialTime),
            ),
          ],
        ),
      ),
    ),
  );
}

Widget calendarTimeForm(BuildContext context, WidgetRef ref, int fromOrTo, EventInitialTime initialTime){
  int hour;
  int minutes;
  DateTime focusedDay = DateTime.now();
  return Consumer(
    builder: (context, ref, _) {
      final times = ref.watch(selectedDateTimeProvider(initialTime));
      if(fromOrTo == 0){
        hour = times['fromHour']!;
        minutes = times['fromMinutes']!;
      }else{
        hour = times['toHour']!;
        minutes = times['toMinutes']!;
      }
      focusedDay = focusedDay.copyWith(hour: hour, minute: minutes);
      print(times);
      return InkWell(
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
              int pickedHour = picked.hour;
              int pickedMinutes = picked.minute;
              ref.read(selectedDateTimeProvider(initialTime).notifier).saveState(pickedHour, pickedMinutes, fromOrTo);
            }
          });
        },
        child: Text(
          '${hour.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}',
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
      );
    }
  );
}