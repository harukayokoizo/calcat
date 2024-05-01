import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

import '../../../../event/domain/event_document.dart';
import '../../../../notification/presentation/action_sheet.dart';
import '../../../../notification/presentation/notification_settings_button.dart';
import '../../../domain/calendar_document.dart';
import '../edit/calendar_edit.dart';
import '../edit/delete_dialog.dart';

class CalendarFloatingButton extends StatefulWidget{
  CalendarDocument calendarDoc;
  CalendarFloatingButton(this.calendarDoc, {super.key});

  @override
  State<CalendarFloatingButton> createState() => CalendarFloatingButtonState();
}

class CalendarFloatingButtonState extends State<CalendarFloatingButton>{
  late CalendarDocument calendarDoc;

  @override
  void initState() {
    calendarDoc = widget.calendarDoc;
  }

  @override
  Widget build(BuildContext context){
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        SpeedDial(
          childrenButtonSize: const Size(60,60),
          spacing: 5,
          animatedIcon: AnimatedIcons.menu_close,
          animatedIconTheme: const IconThemeData(size: 22.0),
          curve: Curves.bounceIn,
          children: [
            SpeedDialChild(
              label: '編集',
              child: const Icon(Icons.edit),
              shape: const CircleBorder(),
              backgroundColor: Colors.blue.shade50,
              onTap: () {
                showCupertinoModalPopup(
                  context: context,
                  builder: (BuildContext context) {
                    return CalendarEditForm(calendarDoc);
                  },
                ).then((value){
                  if(value != null){
                    Navigator.pop(context);
                  }
                });
              },
            ),
            SpeedDialChild(
              label: '削除',
              shape: const CircleBorder(),
              child: const Icon(Icons.delete),
              backgroundColor: Colors.blue.shade50,
              onTap: () async {
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
            ),
          ],
        ),
      ],
    );
  }
}