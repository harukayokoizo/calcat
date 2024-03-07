import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_calendar/src/features/personal_event/presentation/event_registration/repeat_form.dart';

import '../../application/personal_event_provider.dart';
import '../../domain/personal_event.dart';
import '../event_registration/color_form.dart';
import '../event_registration/date_form.dart';
import '../event_registration/notification_form.dart';

class PersonalEventEdit extends ConsumerWidget{
  PersonalEvent event;
  PersonalEventEdit(this.event, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref){
    ref.watch(personalEventFormStateProvider(event));
    return Scaffold(
      appBar: AppBar(
        elevation: 5,
        titleTextStyle: const TextStyle(
          color: Colors.black,
          fontSize: 20,
          //fontWeight: FontWeight.bold,
        ),
        title: const Text('予定編集'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            decoration: const BoxDecoration(
              border: Border(
                  top: BorderSide(color: Colors.grey, width: 1.0),
                  bottom: BorderSide(color: Colors.grey, width: 1.0)
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: TextFormField(
                //controller: titleController,
                decoration: const InputDecoration(
                    hintText: 'イベント名',
                    border: InputBorder.none
                ),
                onChanged: (value){
                  ref.read(personalEventFormStateProvider(event).notifier).changeTitle(value);
                },
              ),
            ),
          ),
          Container(
            decoration: const BoxDecoration(
              border: Border(
                //top: BorderSide(color: Colors.grey, width: 1.0),
                  bottom: BorderSide(color: Colors.grey, width: 1.0)
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: TextFormField(
                //controller: titleController,
                decoration: const InputDecoration(
                    hintText: 'イベント内容',
                    border: InputBorder.none
                ),
                onChanged: (value){
                  ref.read(personalEventFormStateProvider(event).notifier).changeEvent(value);
                },
              ),
            ),
          ),
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
              child: SaveEventButton(event),
            ),
          )
        ],
      ),
    );
  }
}

class SaveEventButton extends ConsumerWidget{
  PersonalEvent event;
  SaveEventButton(this.event, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref){
    final personalEvent = ref.watch(personalEventFormStateProvider(event));
    return ElevatedButton(
      onPressed: personalEvent.title == null || personalEvent.title!.isEmpty ? null : (){
        // ref.read(personalEventFormStateProvider.notifier).createEvent();
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