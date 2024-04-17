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
      padding: const EdgeInsets.only(left: 20, top: 10.0, right: 20.0),
      child: InkWell(
        onTap: (){
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => FollowCalendarPage(calendarDoc),
            ),
          );
        },
        child: Container(
          height: 100,
          width: deviceWidth,
          decoration: BoxDecoration(
            //color: Colors.blue,
            border: const Border(
                bottom: BorderSide(width: 1.0, color: Color(0xFFD8D8D8)),
                right: BorderSide(width: 1.0, color: Color(0xFFD8D8D8))
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            children: [
              calendarIcon(calendarDoc.calendar!.image),
              calendarSummary(calendarDoc.calendar!.title!, calendarDoc.calendar!.description!),
            ],
          ),
        ),
      ),
    );
  }

}