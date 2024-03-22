import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../personal_event/domain/event_document.dart';
import '../../../personal_event/presentation/event/detail/event_detail.dart';
import '../../../personal_event/presentation/event/list/component/event_tile.dart';
import '../../../personal_event/presentation/event/registration/event_registration.dart';
import 'event_detail.dart';


class PublicListWidget extends StatelessWidget{
  dynamic repositories;
  dynamic calendarFormat;
  dynamic focusedDayState;
  String date;
  List eventOnDate;
  DateTime focusedDay;
  bool followCalendar;

  PublicListWidget(
      this.repositories,
      this.calendarFormat,
      this.focusedDayState,
      this.date,
      this.eventOnDate,
      this.focusedDay,
      this.followCalendar,
      {super.key}
      );

  @override
  Widget build(BuildContext context) {
    return Column(
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
        if(eventOnDate.isNotEmpty)
          Flexible(
            flex: 5,
            child: Align(
              alignment: Alignment.topCenter,
              child: LayoutBuilder(
                  builder: (context, constraint) {
                    return SingleChildScrollView(
                      child: Column(
                        children: [
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
                    );
                  }
              ),
            ),
          )
        else
          const Center(child: Text('予定はありません。', style: TextStyle(fontWeight: FontWeight.bold),)),

        Flexible(
          flex: 1,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                  onPressed: (){
                    final previousDate = focusedDay.subtract(const Duration(days: 1));
                    focusedDayState.saveState(focusedDay: previousDate);
                  },
                  icon: const Icon(Icons.arrow_back_ios_new)
              ),
              if(!followCalendar)
                IconButton(
                  onPressed: (){
                    showCupertinoModalPopup(
                        context: context,
                        builder: (BuildContext context) => EventRegistration(focusedDayState.state, repositories)
                    );
                  },
                  icon: const Icon(Icons.add,color: Colors.white,),
                  style: IconButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                  ),
                ),
              IconButton(
                  onPressed: (){
                    final nextDate = focusedDay.add(const Duration(days: 1));
                    focusedDayState.saveState(focusedDay: nextDate);
                  },
                  icon: const Icon(Icons.arrow_forward_ios)
              ),
            ],
          ),
        )
      ],
    );
  }

}