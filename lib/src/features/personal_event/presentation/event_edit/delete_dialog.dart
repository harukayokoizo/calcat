import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_calendar/src/features/personal_event/domain/event_document.dart';

import '../../data/personal_event_repositories.dart';

class DeleteDialog extends ConsumerWidget{
  int value;
  EventDocument eventDoc;
  DeleteDialog(this.value, this.eventDoc, {super.key});

  @override

  Widget build(BuildContext context, WidgetRef ref) {
    return CupertinoAlertDialog(
      title: const Text('予定の削除'),
      content: const Padding(
        padding: EdgeInsets.only(top: 8.0),
        child: Text('本当にこの予定を削除しますか？',),
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
              if(value == 0 || value == 1){
                ref.read(eventRepositories).deleteEvent(eventDoc.docId!)
                    .then((value){
                      Navigator.pop(context, true);
                    });
              }else if(value == 2){
                ref.read(eventRepositories).deleteSameEvents(eventDoc).then((value){
                  Navigator.pop(context, true);
                });
              }

            }
        ),
      ],
    );
  }
}