import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_calendar/src/features/todo/presentation/detail/task_list.dart';
import 'package:share_calendar/src/features/todo/presentation/detail/todo_title_form.dart';

import '../../data/task_repositories.dart';
import '../../domain/todo.dart';
import '../../domain/todo_document.dart';

class TodoDetail extends ConsumerWidget{
  final TodoDocument todoDocument;
  const TodoDetail(this.todoDocument, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref){
    Todo todo = todoDocument.todo!;
    String todoId = todoDocument.docId!;
    return Scaffold(
      appBar: AppBar(),
      body: TaskList(todoDocument),
      //   Column(
      //   children: [
      //     TodoTitleForm(todoDocument),
      //     TaskList(todoDocument)
      //   ],
      // ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue.shade500,
        shape: const CircleBorder(),
        heroTag: "search",
        child: const Icon(Icons.add, color: Colors.white),
        onPressed: () async {
          await ref.read(taskRepositories).createTask(todo.calendarId!, todoId);
        },

      ),
    );
  }
}