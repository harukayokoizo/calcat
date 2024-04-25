// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
//
// import '../../../domain/calendar.dart';
// import '../../../domain/calendar_document.dart';
// import 'calendar_edit.dart';
//
// class CalendarEditActionButton extends ConsumerWidget{
//   CalendarDocument calendarDoc;
//
//   CalendarEditActionButton(this.calendarDoc, {super.key});
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref){
//     return FloatingActionButton(
//         heroTag: "edit",
//         child: const Icon(Icons.edit),
//         onPressed: () async {
//           showCupertinoModalPopup(
//             context: context,
//             builder: (BuildContext context) {
//               return CalendarEditForm(calendarDoc);
//             },
//           ).then((value){
//             if(value != null){
//               Navigator.pop(context);
//             }
//           });
//         }
//     );
//   }
//
// }