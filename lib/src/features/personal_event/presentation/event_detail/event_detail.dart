import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../application/personal_event_provider.dart';
import '../../domain/event_document.dart';
import '../../domain/personal_event.dart';
import '../event_edit/delete_dialog.dart';
import '../event_edit/event_edit_page.dart';
import '../event_registration/date_form.dart';
import 'action_sheet.dart';
import 'event_color_detail.dart';
import 'event_date_detail.dart';
import 'event_notification_detail.dart';
import 'event_repeat_detail.dart';
import 'modal_bottom_sheet.dart';

class EventDetail extends ConsumerWidget{
  EventDocument eventDoc;
  EventDetail(this.eventDoc, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    PersonalEvent event = eventDoc.event!;
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
              if (event.repeat != 0) {
                showCupertinoModalPopup(
                    context: context,
                    builder: (BuildContext context) => const ActionSheet()
                ).then((value) {
                  if (value != null) {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return DeleteDialog(value, eventDoc);
                      },
                    ).then((value){
                      if(value){
                        Navigator.pop(context);
                      }
                    });
                  }
                });
              }else{
                showCupertinoDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return DeleteDialog(0, eventDoc);
                  },
                ).then((value){
                  if(value){
                    Navigator.pop(context);
                  }
                });
              }
            },
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: FloatingActionButton(
              heroTag: "edit",
              child: Icon(Icons.edit),
              backgroundColor: Colors.blue[200],
              onPressed: () async {
                if (event.repeat != 0) {
                  showCupertinoModalPopup(
                      context: context,
                      builder: (BuildContext context) => const ActionSheet()
                  ).then((value) {
                    if (value != null) {
                      showModalBottomSheet(
                        isScrollControlled: true,
                        backgroundColor: const Color.fromRGBO(0, 0, 0, 0.0),
                        context: context,
                        builder: (BuildContext context) {
                          return PersonalEventEdit(eventDoc, value);
                        },
                      );
                    }
                  });
                }else{
                  showModalBottomSheet(
                    isScrollControlled: true,
                    backgroundColor: const Color.fromRGBO(0, 0, 0, 0.0),
                    context: context,
                    builder: (BuildContext context) {
                      return PersonalEventEdit(eventDoc, 0);
                    },
                  );
                }
              }
            ),
          ),
        ],
      ),
    );
  }
}