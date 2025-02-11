import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/todo_repositories.dart';
import '../../domain/todo_document.dart';


class TodoDeleteDialog extends ConsumerWidget{
  final TodoDocument todoDocument;
  const TodoDeleteDialog(this.todoDocument, {super.key});

  @override

  Widget build(BuildContext context, WidgetRef ref) {
    return CupertinoAlertDialog(
      title: const Text('Todoの削除'),
      content: const Padding(
        padding: EdgeInsets.only(top: 8.0),
        child: Text('本当にこのTodoを削除しますか？',),
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
              style: TextStyle(color: Colors.red),
            ),
            onPressed: () async{
              ref.read(todoRepositories).deleteTodo(todoDocument);
              Navigator.pop(context, true);
            }
        ),
      ],
    );
  }
}