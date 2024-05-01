import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

import '../../../../notification/presentation/action_sheet.dart';
import '../../../../notification/presentation/notification_settings_button.dart';
import '../../../domain/event.dart';
import '../../../domain/event_document.dart';
import '../edit/delete_dialog.dart';
import '../edit/event_edit_page.dart';
import 'action_sheet.dart';

class EventFloatingButton extends StatefulWidget{
  EventDocument eventDoc;
  dynamic repositories;
  bool public;
  EventFloatingButton(this.eventDoc, this.repositories, this.public, {super.key});

  @override
  State<EventFloatingButton> createState() => EventFloatingButtonState();
}

class EventFloatingButtonState extends State<EventFloatingButton>{
  late EventDocument eventDoc;
  late Event event;
  late dynamic repositories;
  late bool public;
  bool notification = false;

  @override
  void initState() {
    eventDoc = widget.eventDoc;
    repositories = widget.repositories;
    notification = widget.eventDoc.event!.notificationExist!;
    public = widget.public;
    event = widget.eventDoc.event!;
  }

  @override
  Widget build(BuildContext context){
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        SpeedDial(
          childrenButtonSize: const Size(60,60),
          spacing: 5,
          animatedIcon: AnimatedIcons.menu_close,
          animatedIconTheme: const IconThemeData(size: 22.0),
          curve: Curves.bounceIn,
          children: [
            SpeedDialChild(
              label: '編集',
              shape: const CircleBorder(),
              child: const Icon(Icons.edit),
              backgroundColor: Colors.blue.shade50,
              onTap: () async {
                if (event.repeat != 0) {
                  showCupertinoModalPopup(
                      context: context,
                      builder: (BuildContext context) => const ActionSheet()
                  ).then((value) {
                    if (value != null) {
                      showCupertinoModalPopup(
                        context: context,
                        builder: (BuildContext context) {
                          return EventEdit(eventDoc, value, repositories);
                        },
                      ).then((value){
                        if(value){
                          Navigator.pop(context);
                        }
                      });
                    }
                  });
                }else{
                  showCupertinoModalPopup(
                    context: context,
                    builder: (BuildContext context) {
                      return EventEdit(eventDoc, 0, repositories);
                    },
                  ).then((value){
                    if(value){
                      Navigator.pop(context);
                    }
                  });
                }
              },
            ),
            SpeedDialChild(
              label: '削除',
              child: const Icon(Icons.delete),
              shape: const CircleBorder(),
              backgroundColor: Colors.blue.shade50,
              onTap: () {
                if (event.repeat != 0) {
                  showCupertinoModalPopup(
                      context: context,
                      builder: (BuildContext context) => const ActionSheet()
                  ).then((value) {
                    if (value != null) {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return DeleteDialog(value, eventDoc, repositories);
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
                      return DeleteDialog(0, eventDoc, repositories);
                    },
                  ).then((value){
                    if(value){
                      Navigator.pop(context);
                    }
                  });
                }
              },
            ),
            SpeedDialChild(
              label: '通知',
              shape: const CircleBorder(),
              backgroundColor: Colors.blue.shade50,
              child: notification ? const Icon(Icons.notifications_active) : const Icon(Icons.notifications_off_outlined),
              onTap: () async {
                showCupertinoModalPopup(
                    context: context,
                    builder: (BuildContext context) => NotificationActionSheet(eventDoc, public)
                ).then((value) {
                  if(value != null){
                    setState(() {
                      notification = value;
                    });
                  }
                });
              },
            ),
          ],
        ),
      ],
    );
  }
}