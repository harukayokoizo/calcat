import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../domain/event.dart';
import 'event_color.dart';
import 'event_summary.dart';
import 'event_time.dart';

class EventTile extends ConsumerWidget{
  Event event;
  DateTime focusedDay;
  EventTile(this.event, this.focusedDay, {super.key});

  @override

  Widget build(BuildContext context, WidgetRef ref){
    return Padding(
      padding: const EdgeInsets.only(left: 15.0, right: 15.0, bottom: 15.0),
      child: PhysicalModel(
        elevation: 5,
        color: Colors.white,
        //borderRadius: BorderRadius.circular(20),
        child: Container(
          height: 100,
          decoration: const BoxDecoration(
            //borderRadius: BorderRadius.circular(20),
            color: Colors.white,
          ),
          child: Row(
            children: [
              eventTime(event.isAllDay!, event.from!, event.to!, focusedDay),
              eventColor(event.color!),
              Expanded(
                //flex: 5,
                  child: eventSummary(event.title!, event.overview)
              ),
            ],
          ),
        ),
      ),
    );
  }
}