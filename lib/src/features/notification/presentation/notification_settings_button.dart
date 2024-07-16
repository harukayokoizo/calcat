import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../event/domain/event_document.dart';
import '../../event/presentation/event/detail/action_sheet.dart';
import '../application/notification_provider.dart';
import '../data/personal_event_notification_repositories.dart';
import 'action_sheet.dart';

class NotificationButton extends StatefulWidget{
  final EventDocument eventDoc;
  final bool public;
  final bool notification;

  const NotificationButton(this.eventDoc, this.public, this.notification, {super.key});
  @override
  State<NotificationButton> createState() => NotificationButtonState();
}

class NotificationButtonState extends State<NotificationButton>{
  late EventDocument eventDoc;
  late bool public;
  late bool notification;

  @override
  void initState() {
    super.initState();
    eventDoc = widget.eventDoc;
    public = widget.public;
    notification = widget.notification;
  }
  @override
  Widget build(BuildContext context){
    Icon notificationIcon = notification ? const Icon(Icons.notifications_active): const Icon(Icons.notifications_off_outlined);
    return FloatingActionButton(
        heroTag: "notification_delete",
        shape: const CircleBorder(),
        child: notificationIcon,
        onPressed: () async {
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
        }
    );

  }

}