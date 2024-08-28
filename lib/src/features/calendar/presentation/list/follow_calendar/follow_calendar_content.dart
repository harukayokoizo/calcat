import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../domain/calendar_document.dart';
import '../published_calendar/published_calendar_content.dart';
import 'calendar.dart';

class FollowCalendarContent extends StatelessWidget{
  CalendarDocument calendarDoc;

  FollowCalendarContent(this.calendarDoc, {super.key});

  @override
  Widget build(BuildContext context){
    final double deviceWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.only(left: 20, top: 15.0, right: 20.0, bottom: 0.0),
      child: InkWell(
        onTap: (){
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => FollowCalendarPage(calendarDoc, false),
            ),
          );
        },
        child: Container(
          height: 100,
          width: deviceWidth,
          decoration: BoxDecoration(
            color: Colors.white,
            // border: const Border(
            //     top: BorderSide(width: 1.0, color: Color(0xFFCCCCCC)),
            //     bottom: BorderSide(width: 1.5, color: Color(0xFFCCCCCC)),
            //     right: BorderSide(width: 1.5, color: Color(0xFFCCCCCC))
            // ),
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.7), // 影の色
                spreadRadius: 1, // スプレッド半径
                blurRadius: 2, // ぼかし半径
                offset: const Offset(0, 1), // オフセット（x, y）
              ),
            ],
          ),
          child: LayoutBuilder(
              builder: (context, constraints) {
                return Row(
                  children: [
                    SizedBox(
                      height: 100,
                      width: 100,
                      child: calendarIcon(calendarDoc.calendar!.image),
                    ),
                    SizedBox(
                      height: 100,
                      width: constraints.maxWidth - 100,
                      child: calendarSummaryWidthCount(calendarDoc.calendar!.title!, calendarDoc.calendar!.description!, calendarDoc.calendar!.followsCount!),
                    ),
                  ],
                );
              }
          ),
        ),
      ),
    );
  }

}