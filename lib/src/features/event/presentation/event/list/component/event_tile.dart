import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../application/color_setting_provider.dart';
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
    final colors = ref.read(colorList);
    return Padding(
      padding: const EdgeInsets.only(top: 5.0, left: 15.0, right: 15.0, bottom: 10.0),
      child: Container(
        height: 80,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Color(colors[event.color!]),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5), // 影の色
              spreadRadius: 2, // スプレッド半径
              blurRadius: 5, // ぼかし半径
              offset: const Offset(0, 3), // オフセット（x, y）
            ),
          ],
        ),
        child: Row(
          children: [
            eventTime(event.isAllDay!, event.from!, event.to!, focusedDay, colors[event.color!]),
            // eventColor(event.color!),
            Expanded(
              //flex: 5,
                child: eventSummary(event.title!, event.overview, colors[event.color!])
            ),
          ],
        ),
      ),
    );
  }
}