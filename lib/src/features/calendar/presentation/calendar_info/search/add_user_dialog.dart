import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/calendar_repositories.dart';
import '../../../data/calendar_user_repositories.dart';
import '../../../domain/calendar_document.dart';
import '../../../domain/calendar_user.dart';


class DeleteCalendarOwnerDialog extends ConsumerWidget{
  final CalendarDocument calendarDoc;
  final String uid;
  const DeleteCalendarOwnerDialog(this.calendarDoc, this.uid, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final String docId = calendarDoc.docId!;
    List<String> ownerList = List<String>.from(calendarDoc.calendar!.calendarOwner!);

    return CupertinoAlertDialog(
      title: const Text('カレンダーの編集権限削除'),
      content: const Padding(
        padding: EdgeInsets.only(top: 8.0),
        child: Text('このユーザーの編集権限を削除しますか？',),
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
            onPressed: (){
              ownerList.remove(uid);
              Map<String, dynamic> data = {
                'updated': DateTime.now(),
                'calendarOwner': ownerList,
              };
              ref.read(calendarRepositories).editCalendar(data, docId).then((value){
                Navigator.pop(context, true);
              });
            }
        ),
      ],
    );
  }
}

class AddCalendarOwnerDialog extends ConsumerWidget{
  final CalendarDocument calendarDoc;
  final String uid;
  const AddCalendarOwnerDialog(this.calendarDoc, this.uid, {super.key});

  @override

  Widget build(BuildContext context, WidgetRef ref) {
    final String docId = calendarDoc.docId!;
    List<String> ownerList = List<String>.from(calendarDoc.calendar!.calendarOwner!);

    return CupertinoAlertDialog(
      title: const Text('カレンダーの編集権限追加'),
      content: const Padding(
        padding: EdgeInsets.only(top: 8.0),
        child: Text('このユーザーに編集権限を追加しますか？',),
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
              "追加",
            ),
            onPressed: (){
              ownerList.add(uid);
              Map<String, dynamic> data = {
                'updated': DateTime.now(),
                'calendarOwner': ownerList,
              };
              ref.read(calendarRepositories).editCalendar(data, docId).then((value){
                Navigator.pop(context, true);
              });
            }
        ),
      ],
    );
  }
}