import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../domain/personal_event.dart';
import '../event_registration/date_form.dart';
import 'event_color_detail.dart';
import 'event_date_detail.dart';
import 'event_notification_detail.dart';
import 'event_repeat_detail.dart';

class EventDetail extends StatelessWidget{
  PersonalEvent event;
  EventDetail(this.event, {super.key});

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        elevation: 5,
        titleTextStyle: const TextStyle(
          color: Colors.black,
          fontSize: 20,
          //fontWeight: FontWeight.bold,
        ),
        title: const Text('詳細'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            width: deviceWidth,
            decoration: const BoxDecoration(
              border: Border(
                  top: BorderSide(color: Colors.grey, width: 1.0),
                  bottom: BorderSide(color: Colors.grey, width: 1.0)
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                  event.title!,
                style: const TextStyle(
                  fontSize: 18
                ),
              ),
            ),
          ),
          if(event.event != null)
          Container(
            width: deviceWidth,
            decoration: const BoxDecoration(
              border: Border(
                //top: BorderSide(color: Colors.grey, width: 1.0),
                  bottom: BorderSide(color: Colors.grey, width: 1.0)
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                event.event!,
                style: const TextStyle(
                    fontSize: 18
                ),
              ),
            ),
          ),
          EventDateDetail(event),
          EventColorDetail(event),
          EventNotificationDetail(event),
          EventRepeatDetail(event)
        ],
      ),
    );
  }

}