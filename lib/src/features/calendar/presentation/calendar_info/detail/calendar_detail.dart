import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:share_calendar/src/features/calendar/presentation/calendar_info/detail/description_widget.dart';
import 'package:share_calendar/src/features/calendar/presentation/calendar_info/detail/icon_widget.dart';
import 'package:share_calendar/src/features/calendar/presentation/calendar_info/detail/title_widget.dart';

import '../../../domain/calendar_document.dart';
import 'floating_action_button.dart';
import 'link_widget.dart';

class CalendarDetail extends StatelessWidget{
  final bool followCalendar;
  final CalendarDocument calendarDoc;
  const CalendarDetail(this.followCalendar, this.calendarDoc, {super.key});

  @override
  Widget build(BuildContext context){
    final double deviceHeight = MediaQuery.of(context).size.height;
    final double bottomPadding = MediaQuery.of(context).padding.bottom;
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(
        top: Radius.circular(20.0),
      ),
      child: Material(
        color: const Color(0xFFF5F5F5),
        child: Stack(
          children: [
            CustomScrollView(
              slivers: <Widget>[
                SliverAppBar(
                  pinned: true,
                  stretch: true,
                  expandedHeight: deviceHeight / 3.0,
                  automaticallyImplyLeading: false,
                  flexibleSpace: FlexibleSpaceBar(
                    // title: const Text('test'),
                    background: CalendarIconWidget(calendarDoc.calendar!),
                  ),
                ),
                SliverList(
                  delegate: SliverChildListDelegate([
                    Column(children: [
                      CalendarTitleWidget(calendarDoc.calendar!),
                      CalendarDescriptionWidget(calendarDoc.calendar!),
                      CalendarLinkWidget(calendarDoc.calendar!),
                    ],)
                  ]
                ))
              ],
            ),
            IconButton(
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
            if(!followCalendar)
              Padding(
                padding: EdgeInsets.only(bottom: bottomPadding, right: 20),
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: CalendarFloatingButton(calendarDoc),
                ),
              ),
          ],
        ),
      ),
    );
  }
}