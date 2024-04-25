import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_calendar/src/features/calendar/presentation/search/selected_calendar.dart';
import '../../domain/calendar_document.dart';
import '../list/published_calendar/published_calendar_content.dart';

class SearchedCalendarContent extends ConsumerWidget{
  CalendarDocument calendarDoc;

  SearchedCalendarContent(this.calendarDoc, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref){
    final double deviceWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.only(left: 20, top: 10.0, right: 20.0),
      child: InkWell(
        onTap: (){
          showCupertinoModalPopup(
            context: context,
            builder: (BuildContext context) {
              return SelectedCalendar(calendarDoc);
            },
          );
        },
        child: Container(
          height: 100,
          width: deviceWidth,
          decoration: BoxDecoration(
            color: Colors.white,
            border: const Border(
                bottom: BorderSide(width: 1.5, color: Color(0xFFCCCCCC)),
                right: BorderSide(width: 1.5, color: Color(0xFFCCCCCC))
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              calendarIcon(calendarDoc.calendar!.image),
              calendarSummary(calendarDoc.calendar!.title!, calendarDoc.calendar!.description!),
            ],
          ),
        ),
      ),
    );
  }

}