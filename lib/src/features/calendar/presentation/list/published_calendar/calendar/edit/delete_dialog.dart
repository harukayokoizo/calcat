import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_calendar/src/features/personal_event/domain/event_document.dart';

import '../../../../../data/calendar_repositories.dart';
import '../../../../../data/calendar_user_repositories.dart';
import '../../../../../domain/calendar_document.dart';
import '../../../../../domain/calendar_user.dart';

class CalendarDeleteDialog extends ConsumerWidget{
  CalendarDocument calendarDoc;
  CalendarDeleteDialog(this.calendarDoc, {super.key});

  @override

  Widget build(BuildContext context, WidgetRef ref) {
    return CupertinoAlertDialog(
      title: const Text('カレンダーの削除'),
      content: const Padding(
        padding: EdgeInsets.only(top: 8.0),
        child: Text('本当にこのカレンダーを削除しますか？',),
      ),
      actions: <Widget>[
        TextButton(
            child: const Text(
              "キャンセル",
            ),
            onPressed: (){
              Navigator.pop(context, false);
            }
        ),
        TextButton(
            child: const Text(
              "削除",
            ),
            onPressed: ()async{
              ref.read(calendarRepositories).deleteCalendar(calendarDoc.docId!)
                  .then((value){
                Navigator.pop(context, true);
              });
            }
        ),
      ],
    );
  }
}

class FollowCalendarDeleteDialog extends ConsumerWidget{
  CalendarUser calendarUser;
  FollowCalendarDeleteDialog(this.calendarUser, {super.key});

  @override

  Widget build(BuildContext context, WidgetRef ref) {
    return CupertinoAlertDialog(
      title: const Text('カレンダーの削除'),
      content: const Padding(
        padding: EdgeInsets.only(top: 8.0),
        child: Text('本当にこのカレンダーを削除しますか？',),
      ),
      actions: <Widget>[
        TextButton(
            child: const Text(
              "キャンセル",
            ),
            onPressed: (){
              Navigator.pop(context, false);
            }
        ),
        TextButton(
            child: const Text(
              "削除",
            ),
            onPressed: ()async{
              ref.read(calendarUserRepositories).deleteFollowCalendarUser(calendarUser.calendar!)
                  .then((value){
                Navigator.pop(context, true);
              });
            }
        ),
      ],
    );
  }
}