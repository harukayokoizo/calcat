import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:share_calendar/src/features/todo/presentation/common/delete_dialog.dart';

import '../../domain/todo_document.dart';

enum MenuItem { deleteTodo, }

class TodoPopupMenu extends StatelessWidget {
  final TodoDocument todoDocument;
  const TodoPopupMenu(this.todoDocument, {super.key});

  @override
  Widget build(BuildContext context){
    return PopupMenuButton <MenuItem>(
      itemBuilder: (BuildContext context) => [
        const PopupMenuItem <MenuItem>(
          value: MenuItem.deleteTodo,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '削除',
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
              Icon(
                Icons.delete,
                color: Colors.red,
              ),
            ],
          ),
        ),
      ],
      onSelected: (MenuItem item) async{
        await showCupertinoDialog(
          context: context,
          builder: (BuildContext context) {
            return TodoDeleteDialog(todoDocument);
          },
        ).then((delete){
          if(delete){
            Navigator.pop(context);
          }
        });
      },
      position: PopupMenuPosition.under,
      padding: const EdgeInsets.all(16.0),
      child: const Icon(Icons.settings),
    );
  }
}
