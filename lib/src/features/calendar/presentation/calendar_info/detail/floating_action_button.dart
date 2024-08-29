import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:share_calendar/src/features/calendar/presentation/calendar_info/search/user_search_form.dart';

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
    super.initState();
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
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CalendarEditForm(calendarDoc),
                  ),
                ).then((value){
                  if(value != null){
                    Navigator.pop(context);
                  }
                });
                // showCupertinoModalPopup(
                //   context: context,
                //   builder: (BuildContext context) {
                //     return CalendarEditForm(calendarDoc);
                //   },
                // ).then((value){
                //   if(value != null){
                //     Navigator.pop(context);
                //   }
                // });
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
            SpeedDialChild(
              label: '検索',
              child: const Icon(Icons.search),
              shape: const CircleBorder(),
              backgroundColor: Colors.blue.shade50,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UserSearch(calendarDoc),
                  ),
                ).then((value){
                  if(value != null){
                    Navigator.pop(context);
                  }
                });
                // showCupertinoModalPopup(
                //   context: context,
                //   builder: (BuildContext context) {
                //     return UserSearch(calendarDoc);
                //   },
                // ).then((value){
                //   if(value != null){
                //     Navigator.pop(context);
                //   }
                // });
              },
            ),
          ],
        ),
      ],
    );
  }
}