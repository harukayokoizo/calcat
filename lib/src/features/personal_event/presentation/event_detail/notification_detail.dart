import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../application/notification_setting_provider.dart';
import '../../domain/personal_event.dart';

class EventNotificationDetail extends ConsumerWidget{
  PersonalEvent personalEvent;
  EventNotificationDetail(this.personalEvent, {super.key});

  @override

  Widget build(BuildContext context, WidgetRef ref){
    final notification = ref.read(notificationList);
    final double deviceWidth = MediaQuery.of(context).size.width;
    String time = '';
    for(int num in personalEvent.notification!){
      time = '$time${notification[num]}, ';
    }

    if(time.isNotEmpty){
      time = time.substring(0, time.length - 2);
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
            const Icon(Icons.notifications_none),
            const Padding(
              padding: EdgeInsets.only(left: 4.0),
              child: Text(
                '通知',
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
                  child: Text(time,
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