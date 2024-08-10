import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../../domain/event_document.dart';
import '../../detail/event_detail.dart';
import '../../registration/event_registration.dart';
import 'event_tile.dart';

class ListWidget extends StatelessWidget{
  dynamic repositories;
  dynamic calendarFormat;
  dynamic focusedDayState;
  String date;
  List eventOnDate;
  DateTime focusedDay;

  ListWidget(
      this.repositories,
      this.calendarFormat,
      this.focusedDayState,
      this.date,
      this.eventOnDate,
      this.focusedDay,
      {super.key}
      );

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
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
        body: Stack(
          children: [
            Column(
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
                  flex: 6,
                  child: Align(
                    //alignment: Alignment.topCenter,
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
                                                builder: (context) => EventDetail(eventDoc, repositories),
                                              ),
                                            );
                                          },
                                          child: EventTile(eventDoc.event!, focusedDay)
                                      ),
                                  const SizedBox(height: 30,),
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
            GestureDetector(
              onVerticalDragDown: (details) {
                calendarFormat.state = CalendarFormat.month;
              },
              child: AbsorbPointer(
                child: SizedBox(
                  height: 20,
                  width: deviceWidth,
                  child: Center(
                    child: Container(
                      height: 5,
                      width: 50,
                      decoration: const BoxDecoration(
                          color: Color(0xFFD8D8D8),
                          borderRadius: BorderRadius.all(Radius.circular(30))
                      ),
                    ),
                  ),
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
                builder: (BuildContext context) => EventRegistration(focusedDayState.state, repositories, null)
            );
          },
        ),
      )
    );
  }

}