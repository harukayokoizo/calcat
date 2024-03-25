import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:share_calendar/src/features/calendar/presentation/list/published_calendar/calendar/detail/title_widget.dart';

import '../../../../../domain/calendar_document.dart';
import '../edit/delete_action_button.dart';
import '../edit/edit_action_button.dart';
import 'description_widget.dart';
import 'icon_widget.dart';

class CalendarDetail extends StatelessWidget{
  bool followCalendar;
  CalendarDocument calendarDoc;
  CalendarDetail(this.followCalendar, this.calendarDoc, {super.key});

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: SizedBox(
                  child: Column(children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: IconButton(
                        icon: const Icon(Icons.arrow_back_ios),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                    CalendarIconWidget(calendarDoc.calendar!),
                    CalendarTitleWidget(calendarDoc.calendar!),
                    CalendarDescriptionWidget(calendarDoc.calendar!),
                  ],)
                ),
              ),
            ),
          ]
      ),
      floatingActionButton: followCalendar ? null : Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          if(!followCalendar)
            CalendarDeleteActionButton(calendarDoc),
          if(!followCalendar)
            Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: CalendarEditActionButton(calendarDoc)
            ),
        ],
      ),
    );
  }
}