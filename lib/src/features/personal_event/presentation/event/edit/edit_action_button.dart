import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../domain/event.dart';
import '../../../domain/event_document.dart';
import '../detail/action_sheet.dart';
import 'delete_dialog.dart';
import 'event_edit_page.dart';

class EditActionButton extends StatelessWidget{
  EventDocument eventDoc;
  dynamic repositories;

  EditActionButton(this.eventDoc, this.repositories, {super.key});

  @override
  Widget build(BuildContext context){
    Event event = eventDoc.event!;
    return FloatingActionButton(
        heroTag: "edit",
        child: const Icon(Icons.edit),
        //backgroundColor: Colors.blue[200],
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
            showModalBottomSheet(
              isScrollControlled: true,
              backgroundColor: const Color.fromRGBO(0, 0, 0, 0.0),
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
        }
    );
  }

}