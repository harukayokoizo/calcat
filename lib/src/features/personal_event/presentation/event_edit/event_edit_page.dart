import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_calendar/src/features/personal_event/presentation/event_registration/repeat_form.dart';

import '../../application/personal_event_provider.dart';
import '../../domain/event_document.dart';
import '../../domain/personal_event.dart';
import '../event_registration/color_form.dart';
import '../event_registration/date_form.dart';
import '../event_registration/notification_form.dart';
import '../event_registration/overview_form.dart';
import '../event_registration/title_form.dart';

class PersonalEventEdit extends ConsumerWidget{
  EventDocument eventDoc;
  int value;
  PersonalEventEdit(this.eventDoc, this.value, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref){
    final double deviceHeight = MediaQuery.of(context).size.height;
    bool visible = true;
    PersonalEvent event = eventDoc.event!;
    if(value == 1){
      visible = false;
      event = event.copyWith(repeat: 0, endDate: null);
      ref.watch(personalEventFormStateProvider(event));
    }else{
      ref.watch(personalEventFormStateProvider(event));
    }

    return SizedBox(
      height: deviceHeight - 30,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop(false);
            },
            icon: Icon(Icons.close),
          ),
          elevation: 5,
          titleTextStyle: const TextStyle(
            color: Colors.black,
            fontSize: 20,
            //fontWeight: FontWeight.bold,
          ),
          title: const Text('予定編集'),
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
              Visibility(
                visible: visible,
                  child: RepeatForm(event)
              ),
              const Expanded(
                child: SizedBox(),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10.0, right: 20.0),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: SaveEventButton(eventDoc, event, value),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class SaveEventButton extends ConsumerWidget{
  EventDocument eventDoc;
  PersonalEvent event;
  int value;
  SaveEventButton(this.eventDoc, this.event, this.value, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref){
    //PersonalEvent event = eventDoc.event!;
    final personalEvent = ref.watch(personalEventFormStateProvider(event));
    return ElevatedButton(
      onPressed: personalEvent.title == null || personalEvent.title!.isEmpty ? null : (){
        ref.read(personalEventFormStateProvider(event).notifier).updateEvent(value, eventDoc);
        Navigator.of(context).pop(true);
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