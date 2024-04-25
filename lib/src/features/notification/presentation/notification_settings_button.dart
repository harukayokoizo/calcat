import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../event/domain/event_document.dart';
import '../../event/presentation/event/detail/action_sheet.dart';
import '../application/notification_provider.dart';
import '../data/personal_event_notification_repositories.dart';
import 'action_sheet.dart';

class NotificationButton extends StatefulWidget{
  EventDocument eventDoc;
  bool public;

  NotificationButton(this.eventDoc, this.public, {super.key});
  @override
  State<NotificationButton> createState() => NotificationButtonState();
}

class NotificationButtonState extends State<NotificationButton>{
  bool notification = false;

  @override
  void initState() {
    notification = widget.eventDoc.event!.notificationExist!;
  }
  @override
  Widget build(BuildContext context){
    return FloatingActionButton(
        heroTag: "notification_delete",
        shape: const CircleBorder(),
        child: notification ? const Icon(Icons.notifications_active) : const Icon(Icons.notifications_off_outlined),
        onPressed: () async {
          showCupertinoModalPopup(
              context: context,
              builder: (BuildContext context) => NotificationActionSheet(widget.eventDoc, widget.public)
          ).then((value) {
            if(value != null){
              setState(() {
                notification = value;
              });
            }
          });
        }
    );

  }

}