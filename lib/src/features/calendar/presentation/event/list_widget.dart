import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../event/domain/event_document.dart';
import '../../../event/presentation/event/detail/event_detail.dart';
import '../../../event/presentation/event/list/component/event_tile.dart';
import '../../../event/presentation/event/registration/event_registration.dart';
import 'event_detail.dart';


class PublicListWidget extends StatelessWidget{
  dynamic repositories;
  dynamic calendarFormat;
  dynamic focusedDayState;
  String date;
  List eventOnDate;
  DateTime focusedDay;
  bool followCalendar;
  String calendarId;

  PublicListWidget(
      this.repositories,
      this.calendarFormat,
      this.focusedDayState,
      this.date,
      this.eventOnDate,
      this.focusedDay,
      this.followCalendar,
      this.calendarId,
      {super.key}
      );

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragUpdate: (details) {},
      onHorizontalDragEnd: (details){
        if(details.primaryVelocity! < 0.0){
          final nextDate = focusedDay.add(const Duration(days: 1));
          focusedDayState.saveState(focusedDay: nextDate);
        }
        if(details.primaryVelocity! > 0.0){
          final previousDate = focusedDay.subtract(const Duration(days: 1));
          focusedDayState.saveState(focusedDay: previousDate);
        }
      },
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.only(top: 10.0, left: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      date,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      onPressed: (){
                        calendarFormat.state = CalendarFormat.month;
                      },
                      icon: const Icon(
                          Icons.clear
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Flexible(
              flex: 5,
              child: Align(
                alignment: Alignment.topCenter,
                child: LayoutBuilder(
                    builder: (context, constraint) {
                      return SizedBox(
                        height: constraint.maxHeight,
                        width: constraint.maxWidth,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              if(eventOnDate.isEmpty)
                                SizedBox(
                                  height: constraint.maxHeight,
                                  width: constraint.maxWidth,
                                  child: const Padding(
                                    padding: EdgeInsets.only(left: 20.0),
                                    child: Text(
                                      '予定はありません。',
                                      style: TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              if(eventOnDate.isNotEmpty)
                                for(EventDocument eventDoc in eventOnDate)
                                  InkWell(
                                      onTap: (){
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            fullscreenDialog: true,
                                            builder: (context) => PublicEventDetail(eventDoc, repositories, followCalendar),
                                          ),
                                        );
                                      },
                                      child: EventTile(eventDoc.event!, focusedDay)
                                  )
                            ],
                          ),
                        ),
                      );
                    }
                ),
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.blue.shade500,
          heroTag: "add calendar",
          shape: const CircleBorder(),
          child: const Icon(Icons.add, color: Colors.white),
          //backgroundColor: Colors.blue[200],
          onPressed: (){
            showCupertinoModalPopup(
                context: context,
                builder: (BuildContext context) => EventRegistration(focusedDayState.state, repositories, calendarId)
            );
          },
        ),
      ),
    );
  }

}