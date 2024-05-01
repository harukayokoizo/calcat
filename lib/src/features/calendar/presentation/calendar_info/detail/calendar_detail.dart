import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:share_calendar/src/features/calendar/presentation/calendar_info/detail/description_widget.dart';
import 'package:share_calendar/src/features/calendar/presentation/calendar_info/detail/icon_widget.dart';
import 'package:share_calendar/src/features/calendar/presentation/calendar_info/detail/title_widget.dart';

import '../../../domain/calendar_document.dart';
import 'floating_action_button.dart';

class CalendarDetail extends StatelessWidget{
  bool followCalendar;
  CalendarDocument calendarDoc;
  CalendarDetail(this.followCalendar, this.calendarDoc, {super.key});

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: SafeArea(
        child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: SizedBox(
                    child: Column(children: [
                      CalendarIconWidget(calendarDoc.calendar!),
                      CalendarTitleWidget(calendarDoc.calendar!),
                      CalendarDescriptionWidget(calendarDoc.calendar!),
                    ],)
                  ),
                ),
              ),
            ]
        ),
      ),
      floatingActionButton: followCalendar ? null : CalendarFloatingButton(calendarDoc)
    );
  }
}