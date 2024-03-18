import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_calendar/src/features/personal_event/presentation/event/registration/repeat_form.dart';
import 'package:share_calendar/src/features/personal_event/presentation/event/registration/title_form.dart';

import '../../../../../common_widgets/application/common_provider.dart';
import '../../../application/event_provider.dart';
import '../../../domain/event.dart';
import 'color_form.dart';
import 'date_form.dart';
import 'notification_form.dart';
import 'overview_form.dart';

class EventRegistration extends ConsumerWidget{
  final DateTime focusedDay;
  dynamic repositories;
  EventRegistration(this.focusedDay, this.repositories, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref){
    final user = ref.read(currentUser);
    Event event = Event(
        uid: user!.uid,
        title: null,
        event: null,
        image: null,
        color: 8,
        isAllDay: true,
        from: focusedDay,
        to: focusedDay,
        notification: [],
        repeat: 0,
        endDate: null,
        sameEventId: null,
        number: null
    );
    ref.watch(eventFormStateProvider(event));
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
            TitleForm(event),
            OverViewForm(event),
            DateSettingFormat(event),
            ColorForm(event),
            NotificationForm(event),
            RepeatForm(event),
            const Expanded(
              child: SizedBox(),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10.0, right: 20.0),
              child: Align(
                  alignment: Alignment.centerRight,
                  child: SaveEventButton(event, repositories),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class SaveEventButton extends ConsumerWidget{
  Event event;
  dynamic repositories;
  SaveEventButton(this.event, this.repositories, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref){
    final personalEvent = ref.watch(eventFormStateProvider(event));

    return ElevatedButton(
      onPressed: personalEvent.title == null || personalEvent.title!.isEmpty ? null : (){
        ref.read(eventFormStateProvider(event).notifier).createEvent(repositories);
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