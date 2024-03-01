import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: PhysicalModel(
                      elevation: 5,
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        height: 80,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white,
                        ),
                      ),
                    ),
                  )
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