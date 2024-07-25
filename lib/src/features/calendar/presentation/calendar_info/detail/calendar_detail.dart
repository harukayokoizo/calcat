import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:share_calendar/src/features/calendar/presentation/calendar_info/detail/description_widget.dart';
import 'package:share_calendar/src/features/calendar/presentation/calendar_info/detail/icon_widget.dart';
import 'package:share_calendar/src/features/calendar/presentation/calendar_info/detail/title_widget.dart';

import '../../../domain/calendar_document.dart';
import 'floating_action_button.dart';

class CalendarDetail extends StatelessWidget{
  final bool followCalendar;
  final CalendarDocument calendarDoc;
  const CalendarDetail(this.followCalendar, this.calendarDoc, {super.key});

  @override
  Widget build(BuildContext context){
    final double topPadding = MediaQuery.of(context).padding.top;
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: SafeArea(
              top: false,
              bottom: false,
              child: SizedBox(
                child: Column(children: [
                  CalendarIconWidget(calendarDoc.calendar!),
                  CalendarTitleWidget(calendarDoc.calendar!),
                  CalendarDescriptionWidget(calendarDoc.calendar!),
                ],)
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: topPadding, left: 5.0),
            child: IconButton(
              icon: const CircularIcon(
                icon: Icons.clear,
                backgroundColor: Colors.grey,
                iconColor: Colors.white,
                size: 35,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
        ],
      ),
      floatingActionButton: followCalendar ? null : CalendarFloatingButton(calendarDoc)
    );
  }
}