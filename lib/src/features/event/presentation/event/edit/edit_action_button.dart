// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
//
// import '../../../../../common_widgets/application/common_provider.dart';
// import '../../../domain/event.dart';
// import '../../../domain/event_document.dart';
// import '../detail/action_sheet.dart';
// import 'delete_dialog.dart';
// import 'event_edit_page.dart';
//
// class EditActionButton extends ConsumerWidget{
//   EventDocument eventDoc;
//   dynamic repositories;
//
//   EditActionButton(this.eventDoc, this.repositories, {super.key});
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref){
//     Event event = eventDoc.event!;
//     return FloatingActionButton(
//         heroTag: "edit",
//         child: const Icon(Icons.edit),
//         //backgroundColor: Colors.blue[200],
//         onPressed: () async {
//           if (event.repeat != 0) {
//             showCupertinoModalPopup(
//                 context: context,
//                 builder: (BuildContext context) => const ActionSheet()
//             ).then((value) {
//               if (value != null) {
//                 showCupertinoModalPopup(
//                   context: context,
//                   builder: (BuildContext context) {
//                     return EventEdit(eventDoc, value, repositories);
//                   },
//                 ).then((value){
//                   if(value){
//                     Navigator.pop(context);
//                   }
//                 });
//               }
//             });
//           }else{
//             showCupertinoModalPopup(
//               context: context,
//               builder: (BuildContext context) {
//                 return EventEdit(eventDoc, 0, repositories);
//               },
//             ).then((value){
//               if(value){
//                 Navigator.pop(context);
//               }
//             });
//           }
//         }
//     );
//   }
//
// }