import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_calendar/src/features/calendar/presentation/search/selected_calendar.dart';
import '../../domain/calendar_document.dart';
import '../list/published_calendar/published_calendar_content.dart';

class SearchedCalendarContent extends ConsumerWidget{
  final CalendarDocument calendarDoc;

  const SearchedCalendarContent(this.calendarDoc, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref){
    final double deviceWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.only(left: 20, top: 15.0, right: 20.0),
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
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.7), // 影の色
                spreadRadius: 1, // スプレッド半径
                blurRadius: 2, // ぼかし半径
                offset: const Offset(0, 1), // オフセット（x, y）
              ),
            ],
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