// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_speed_dial/flutter_speed_dial.dart';
//
// import '../../../domain/event.dart';
// import '../../../domain/event_document.dart';
// import '../detail/action_sheet.dart';
// import 'delete_dialog.dart';
//
// class DeleteActionButton extends StatelessWidget{
//   EventDocument eventDoc;
//   dynamic repositories;
//
//   DeleteActionButton(this.eventDoc, this.repositories, {super.key});
//
//   @override
//   Widget build(BuildContext context){
//     Event event = eventDoc.event!;
//     return FloatingActionButton(
//       heroTag: "delete",
//       child: const Icon(Icons.delete),
//       //backgroundColor: Colors.blue[200],
//       onPressed: () async {
//         if (event.repeat != 0) {
//           showCupertinoModalPopup(
//               context: context,
//               builder: (BuildContext context) => const ActionSheet()
//           ).then((value) {
//             if (value != null) {
//               showDialog(
//                 context: context,
//                 builder: (BuildContext context) {
//                   return DeleteDialog(value, eventDoc, repositories);
//                 },
//               ).then((value){
//                 if(value){
//                   Navigator.pop(context);
//                 }
//               });
//             }
//           });
//         }else{
//           showCupertinoDialog(
//             context: context,
//             builder: (BuildContext context) {
//               return DeleteDialog(0, eventDoc, repositories);
//             },
//           ).then((value){
//             if(value){
//               Navigator.pop(context);
//             }
//           });
//         }
//       },
//     );
//   }
//
// }