import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_calendar/src/features/calendar/domain/calendar_document.dart';

class SelectedCalendar extends ConsumerWidget{
  final CalendarDocument calendarDoc;
  const SelectedCalendar(this.calendarDoc, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref){
    return Container();
  }
}