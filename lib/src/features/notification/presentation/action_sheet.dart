import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../event/data/personal_event_repositories.dart';
import '../../event/domain/event_document.dart';
import '../data/public_event_notification_repositories.dart';

class NotificationActionSheet extends ConsumerWidget{
  EventDocument eventDoc;
  bool public;
  NotificationActionSheet(this.eventDoc, this.public, {super.key});


  @override
  Widget build(BuildContext context, WidgetRef ref){
    return CupertinoActionSheet(
      actions: <Widget>[
        CupertinoActionSheetAction(
          child: const Text('通知あり'),
          onPressed: () {
            if(public){
              ref.read(publicEventNotificationRepositories(eventDoc)).createNotification();
            }else{
              Map<String, dynamic> data = {'notificationExist' : true};
              ref.read(eventRepositories).changeNotificationExist(data, eventDoc.docId!);
            }
            Navigator.pop(context, true);
          },
        ),
        CupertinoActionSheetAction(
          child: const Text('通知なし'),
          onPressed: () {
            if(public){
              ref.read(publicEventNotificationRepositories(eventDoc)).deleteNotification();
            }else{
              Map<String, dynamic> data = {'notificationExist' : false};
              ref.read(eventRepositories).changeNotificationExist(data, eventDoc.docId!);
            }
            Navigator.pop(context, false);
          },
        ),
      ],
      cancelButton: CupertinoActionSheetAction(
        child: const Text('キャンセル'),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}