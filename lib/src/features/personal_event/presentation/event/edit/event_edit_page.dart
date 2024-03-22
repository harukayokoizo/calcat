import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../common_widgets/application/common_provider.dart';
import '../../../application/event_provider.dart';
import '../../../domain/event_document.dart';
import '../../../domain/event.dart';
import '../registration/color_form.dart';
import '../registration/date_form.dart';
import '../registration/notification_form.dart';
import '../registration/overview_form.dart';
import '../registration/repeat_form.dart';
import '../registration/title_form.dart';


class EventEdit extends ConsumerWidget{
  EventDocument eventDoc;
  int value;
  dynamic repositories;
  EventEdit(this.eventDoc, this.value, this.repositories, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref){
    final double deviceHeight = MediaQuery.of(context).size.height;
    bool visible = true;
    Event event = eventDoc.event!;
    if(value == 1){
      visible = false;
      event = event.copyWith(repeat: 0, endDate: null);
      ref.watch(eventFormStateProvider(event));
    }else{
      ref.watch(eventFormStateProvider(event));
    }

    return SizedBox(
      height: deviceHeight,
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
                  child: SaveEventButton(eventDoc, event, value, repositories),
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
  Event event;
  int value;
  dynamic repositories;
  SaveEventButton(this.eventDoc, this.event, this.value, this.repositories, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref){
    //PersonalEvent event = eventDoc.event!;
    final personalEvent = ref.watch(eventFormStateProvider(event));
    return ElevatedButton(
      onPressed: personalEvent.title == null || personalEvent.title!.isEmpty ? null : (){
        ref.read(eventFormStateProvider(event).notifier).updateEvent(value, eventDoc, repositories);
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