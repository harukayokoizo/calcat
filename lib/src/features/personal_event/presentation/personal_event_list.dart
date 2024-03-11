import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:share_calendar/src/features/personal_event/application/color_setting_provider.dart';
import 'package:share_calendar/src/features/personal_event/presentation/event_registration/personal_event_registration.dart';
import 'package:table_calendar/table_calendar.dart';

import '../application/datetime_format.dart';
import '../application/personal_eventlist_provider.dart';
import '../domain/event_document.dart';
import '../domain/personal_event.dart';
import 'event_detail/event_detail.dart';

class PersonalEventList extends ConsumerWidget{
  final DateTime focusedDay;
  const PersonalEventList(this.focusedDay, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref){
    DateTimeFormat dateFormat = ref.read(dateTimeFormatClass(focusedDay));
    String date = dateFormat.dateJaFormat();
    Map eventList = ref.read(personalEventList.notifier).state;
    List eventOnDate = eventList[focusedDay] ?? [];

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
                          ref.read(calendarFormatState.notifier).state = CalendarFormat.month;
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
                child: LayoutBuilder(
                  builder: (context, constraint) {
                    return SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          for(EventDocument eventDoc in eventOnDate)
                            InkWell(
                                onTap: (){
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => EventDetail(eventDoc),
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
                        ref.read(focusedDayProvider.notifier).saveState(focusedDay: previousDate);
                      },
                      icon: const Icon(Icons.arrow_back_ios_new)
                  ),
                  IconButton(
                    onPressed: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => PersonalEventRegistration(focusedDay),
                        ),
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
                        ref.read(focusedDayProvider.notifier).saveState(focusedDay: nextDate);
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

class EventTile extends ConsumerWidget{
  PersonalEvent event;
  DateTime focusedDay;
  EventTile(this.event, this.focusedDay, {super.key});

  @override

  Widget build(BuildContext context, WidgetRef ref){
    return Padding(
      padding: const EdgeInsets.only(left: 15.0, right: 15.0, bottom: 15.0),
      child: PhysicalModel(
        elevation: 5,
        color: Colors.white,
        //borderRadius: BorderRadius.circular(20),
        child: Container(
          height: 100,
          decoration: const BoxDecoration(
            //borderRadius: BorderRadius.circular(20),
            color: Colors.white,
          ),
          child: Row(
            children: [
              eventTime(event.isAllDay!, event.from!, event.to!, focusedDay),
              eventColor(event.color!),
              Expanded(
                  //flex: 5,
                  child: eventSummary(event.title!, event.event)
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget eventTime(bool isAllDay, DateTime from, DateTime to, DateTime focusedDay){
  DateTime fromDate = DateTime(from.year, from.month, from.day);
  DateTime toDate = DateTime(to.year, to.month, to.day);
  DateTime focusedDate = DateTime(focusedDay.year, focusedDay.month, focusedDay.day);
  DateFormat displayFormat = DateFormat("HH:mm");
  String displayFrom = displayFormat.format(from);
  String displayTo = displayFormat.format(to);
  if(!fromDate.isAtSameMomentAs(toDate)){
    if(focusedDate.isAtSameMomentAs(fromDate)){
      displayTo = '00:00';
    }else if(focusedDate.isAtSameMomentAs(toDate)){
      displayFrom = '00:00';
    }else{
      displayFrom = '00:00';
      displayTo = '00:00';
    }
  }

  if(isAllDay){
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: Center(
        child: Text(
          '終日',
          style: TextStyle(
            //fontWeight: FontWeight.bold,
            fontSize: 18
          ),
        ),
      ),
    );
  }else{
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(displayFrom,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 18,
              //fontWeight: FontWeight.bold,
            ),
          ),
          Text(displayTo,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 18,
              //fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

Widget eventColor(int color){
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Consumer(
      builder: (context, ref, _){
        final colors = ref.read(colorList);
        return Container(
          height: 20,
          width: 20,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Color(colors[color]),
          ),
        );
      },
    ),
  );
}

Widget eventSummary(String title, String? overview){
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Flexible(
        flex: 1,
        child: Text(title,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 20,
            //fontWeight: FontWeight.bold,
          ),
        ),
      ),
      if(overview != null)
        Flexible(
          flex: 2,
          child: Text(overview,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 15,
              //fontWeight: FontWeight.bold,
            ),
          ),
        ),
    ],
  );
}