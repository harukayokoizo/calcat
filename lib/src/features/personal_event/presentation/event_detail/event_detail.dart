import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../application/personal_event_provider.dart';
import '../../domain/event_document.dart';
import '../../domain/personal_event.dart';
import '../event_edit/event_edit_page.dart';
import '../event_registration/date_form.dart';
import 'event_color_detail.dart';
import 'event_date_detail.dart';
import 'event_notification_detail.dart';
import 'event_repeat_detail.dart';
import 'modal_bottom_sheet.dart';

final eventDisplay = StateProvider.autoDispose<bool>(
        (ref) => true
);

class EventContent extends ConsumerWidget{
  EventDocument eventDoc;
  EventContent(this.eventDoc, {super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool display = ref.watch(eventDisplay);
    if(display){
      return EventDetail(eventDoc.event!);
    }else{
      return PersonalEventEdit(eventDoc);
    }
  }
}

class EventDetail extends ConsumerWidget{
  PersonalEvent event;
  EventDetail(this.event, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        elevation: 5,
        titleTextStyle: const TextStyle(
          color: Colors.black,
          fontSize: 20,
          //fontWeight: FontWeight.bold,
        ),
        title: const Text('詳細'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            width: deviceWidth,
            decoration: const BoxDecoration(
              border: Border(
                  top: BorderSide(color: Colors.grey, width: 1.0),
                  bottom: BorderSide(color: Colors.grey, width: 1.0)
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                  event.title!,
                style: const TextStyle(
                  fontSize: 18
                ),
              ),
            ),
          ),
          if(event.event != null)
          Container(
            width: deviceWidth,
            decoration: const BoxDecoration(
              border: Border(
                //top: BorderSide(color: Colors.grey, width: 1.0),
                  bottom: BorderSide(color: Colors.grey, width: 1.0)
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                event.event!,
                style: const TextStyle(
                    fontSize: 18
                ),
              ),
            ),
          ),
          EventDateDetail(event),
          EventColorDetail(event),
          EventNotificationDetail(event),
          EventRepeatDetail(event)
        ],
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: "delete",
            child: Icon(Icons.delete),
            backgroundColor: Colors.blue[200],
            onPressed: () async {
              if(event.repeat != 0) {
                final result = await showModalBottomSheet(
                  backgroundColor: const Color.fromRGBO(0, 0, 0, 0.0),
                  context: context,
                  builder: (BuildContext context) {
                    return const ModalBottomSheet();
                  },
                );
              }
            },
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: FloatingActionButton(
              heroTag: "edit",
              child: Icon(Icons.edit),
              backgroundColor: Colors.blue[200],
              onPressed: () async{
                final result = await showModalBottomSheet(
                  backgroundColor: const Color.fromRGBO(0, 0, 0, 0.0),
                  context: context,
                  builder: (BuildContext context) {
                    return const ModalBottomSheet();
                  },
                );
                //ref.watch(eventDisplay.notifier).state = false;
              },
            ),
          ),
        ],
      ),
    );
  }
}