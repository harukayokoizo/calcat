import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_calendar/src/features/event/domain/event_document.dart';

class DeleteLinkDialog extends ConsumerWidget{
  const DeleteLinkDialog({super.key});

  @override

  Widget build(BuildContext context, WidgetRef ref) {
    return CupertinoAlertDialog(
      title: const Text('リンクの削除'),
      content: const Padding(
        padding: EdgeInsets.only(top: 8.0),
        child: Text('リンクを削除しますか？',),
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
              Navigator.pop(context, true);
            }
        ),
      ],
    );
  }
}