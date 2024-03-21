import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_calendar/src/features/calendar/domain/calendar_document.dart';

import '../../application/search_provider.dart';

class SelectedCalendar extends ConsumerWidget{
  final CalendarDocument calendarDoc;
  const SelectedCalendar(this.calendarDoc, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref){
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            ref.read(selectedCalendarProvider.notifier).selectCalendar(null);
            ref.read(searchSwitch.notifier).switchState(false);
            ref.read(resultPage.notifier).resultPage(false);
          },
        ),
      ),
      body: Container(),
    );
  }
}