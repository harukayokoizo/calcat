import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../domain/calendar.dart';
import '../../../domain/calendar_document.dart';
import 'delete_dialog.dart';

class CalendarDeleteActionButton extends StatelessWidget{
  CalendarDocument calendarDoc;

  CalendarDeleteActionButton(this.calendarDoc, {super.key});

  @override
  Widget build(BuildContext context){
    //Calendar calendar = calendarDoc.calendar!;
    return FloatingActionButton(
      heroTag: "delete",
      child: const Icon(Icons.delete),
      onPressed: () async {
        showCupertinoDialog(
          context: context,
          builder: (BuildContext context) {
            return CalendarDeleteDialog(calendarDoc);
          },
        ).then((value){
          if(value){
            Navigator.pop(context, true);
          }
        });
      },
    );
  }

}