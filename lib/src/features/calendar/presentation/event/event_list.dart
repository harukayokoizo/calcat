import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:share_calendar/src/features/personal_event/application/color_setting_provider.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../personal_event/application/datetime_format.dart';
import '../../../personal_event/domain/event.dart';
import '../../../personal_event/domain/event_document.dart';
import '../../../personal_event/presentation/event/registration/event_registration.dart';
import '../../../personal_event/presentation/event_list.dart';
import '../../application/event_list_provider.dart';
import '../../data/event_repositories.dart';
import 'event_detail.dart';

class PublicEventList extends ConsumerWidget{
  final DateTime focusedDay;
  final String calendarDocId;
  const PublicEventList(this.focusedDay, this.calendarDocId, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref){
    final repositories = ref.read(publicEventRepositories(calendarDocId));
    DateTimeFormat dateFormat = ref.read(dateTimeFormatClass(focusedDay));
    String date = dateFormat.dateJaFormat();
    Map eventList = ref.read(publicEventList(calendarDocId));
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
                    ref.read(publicCalendarFormat.notifier).state = CalendarFormat.month;
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
                                    MaterialPageRoute(builder: (context) => PublicEventDetail(eventDoc, repositories),
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
                    ref.read(publicFocusedDay.notifier).saveState(focusedDay: previousDate);
                  },
                  icon: const Icon(Icons.arrow_back_ios_new)
              ),
              IconButton(
                onPressed: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => EventRegistration(focusedDay, repositories),
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
                    ref.read(publicFocusedDay.notifier).saveState(focusedDay: nextDate);
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