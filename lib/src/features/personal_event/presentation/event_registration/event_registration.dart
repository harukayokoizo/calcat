import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_calendar/src/features/personal_event/presentation/event_registration/repeat_form.dart';
import 'package:share_calendar/src/features/personal_event/presentation/event_registration/title_form.dart';

import '../../application/event_provider.dart';
import 'color_form.dart';
import 'date_form.dart';
import 'notification_form.dart';
import 'overview_form.dart';

class EventRegistration extends ConsumerWidget{
  final DateTime focusedDay;
  const EventRegistration(this.focusedDay, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref){
    final event = ref.watch(eventFormStateProvider(null));
    return Scaffold(
      appBar: AppBar(
        elevation: 5,
        titleTextStyle: const TextStyle(
          color: Colors.black,
          fontSize: 20,
          //fontWeight: FontWeight.bold,
        ),
        title: const Text('予定作成'),
        centerTitle: true,
      ),
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: (){
          FocusScope.of(context).unfocus();
        },
        child: Column(
          children: [
            TitleForm(null),
            OverViewForm(null),
            DateSettingFormat(null),
            ColorForm(null),
            NotificationForm(null),
            RepeatForm(null),
            const Expanded(
              child: SizedBox(),
            ),
            const Padding(
              padding: EdgeInsets.only(bottom: 10.0, right: 20.0),
              child: Align(
                  alignment: Alignment.centerRight,
                  child: SaveEventButton(),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class SaveEventButton extends ConsumerWidget{
  const SaveEventButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref){
    final personalEvent = ref.watch(eventFormStateProvider(null));

    return ElevatedButton(
      onPressed: personalEvent.title == null || personalEvent.title!.isEmpty ? null : (){
        ref.read(eventFormStateProvider(null).notifier).createEvent();
        Navigator.of(context).pop();
      },
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
        //side: BorderSide(color: Colors.black)
      ),
      child: const Text(
        "保存",
        style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold
        ),
      ),
    );
  }
}