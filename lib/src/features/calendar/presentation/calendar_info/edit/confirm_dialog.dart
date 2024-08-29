import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/calendar_repositories.dart';
import '../../../data/calendar_user_repositories.dart';
import '../../../domain/calendar_document.dart';
import '../../../domain/calendar_user.dart';


class CalendarEditConfirmDialog extends ConsumerWidget{
  final CalendarDocument calendarDoc;
  const CalendarEditConfirmDialog(this.calendarDoc, {super.key});

  @override

  Widget build(BuildContext context, WidgetRef ref) {
    return CupertinoAlertDialog(
      title: const Text('カレンダーの編集確認'),
      content: const Padding(
        padding: EdgeInsets.only(top: 8.0),
        child: Text('公開しないに変更すると、フォロワーが削除されますが、本当に編集してもよろしいでしょうか。',),
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
              "編集",
            ),
            onPressed: ()async{
              ref.read(calendarUserRepositories).deleteAllFollowCalendar(calendarDoc.docId!).then((value){
                Navigator.pop(context, true);
              });
            }
        ),
      ],
    );
  }
}