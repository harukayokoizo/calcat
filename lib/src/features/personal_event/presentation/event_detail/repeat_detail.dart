import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:share_calendar/src/features/personal_event/presentation/event_registration/repeat_settings_page.dart';

import '../../application/notification_setting_provider.dart';
import '../../application/repeat_setting_provider.dart';
import '../../domain/event.dart';

class EventRepeatDetail extends ConsumerWidget{
  Event event;
  EventRepeatDetail(this.event, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref){
    DateFormat endDateFormat = DateFormat("MM/dd");
    final repeat = ref.read(repeatList);
    final double deviceWidth = MediaQuery.of(context).size.width;
    String text = '';
    if(event.repeat != 0){
      text = '${repeat[event.repeat!]}, ${endDateFormat.format(event.endDate!)}まで';
    }

    return Container(
      width: deviceWidth,
      decoration: const BoxDecoration(
        border: Border(
            bottom: BorderSide(color: Colors.grey, width: 1.0)
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            const Icon(Icons.repeat),
            const Padding(
              padding: EdgeInsets.only(left: 4.0),
              child: Text(
                '繰り返し',
                style: TextStyle(
                  fontSize: 18,
                  //fontWeight: FontWeight.bold
                ),
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: Text(text,
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}