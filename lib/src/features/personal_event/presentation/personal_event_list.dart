import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:share_calendar/src/features/personal_event/application/color_setting_provider.dart';
import 'package:share_calendar/src/features/personal_event/presentation/personal_event_registraiton.dart';
import 'package:table_calendar/table_calendar.dart';

import '../application/datetime_format.dart';
import '../application/personal_eventlist_provider.dart';
import '../domain/personal_event.dart';

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
        Padding(
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
        if(eventOnDate.isNotEmpty)
          Expanded(
            child: SizedBox(
              child: Column(
                children: [
                  for(PersonalEvent event in eventOnDate)
                    EventTile(event)
                ],
              ),
            ),
          )
        else
          const Center(child: Text('予定はありません。', style: TextStyle(fontWeight: FontWeight.bold),)),

        Row(
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
        )
      ],
    );
  }
}

class EventTile extends ConsumerWidget{
  PersonalEvent event;
  EventTile(this.event, {super.key});

  @override

  Widget build(BuildContext context, WidgetRef ref){
    return Padding(
      padding: const EdgeInsets.all(15.0),
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
              eventTime(event.isAllDay!, event.from!, event.to!),
              eventColor(event.color!),
              eventSummary(event.title!, event.event),
            ],
          ),
        ),
      ),
    );
  }
}

Widget eventTime(bool isAllDay, DateTime from, DateTime to){
  DateFormat displayFormat = DateFormat("HH:mm");

  if(isAllDay){
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: Center(
        child: Text(
          '終日',
          style: TextStyle(
            fontWeight: FontWeight.bold,
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
          Text(displayFormat.format(from),
            style: const TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(displayFormat.format(to),
            style: const TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.bold,
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
  return Expanded(
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: 100,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            if(overview != null)
              Text(overview,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
          ],
        ),
      ),
    ),
  );
}