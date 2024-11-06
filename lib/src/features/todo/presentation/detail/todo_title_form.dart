import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_calendar/src/features/todo/presentation/detail/task_list.dart';

import '../../domain/todo.dart';
import '../../domain/todo_document.dart';

class TodoTitleForm extends ConsumerWidget{
  final TodoDocument todoDocument;
  const TodoTitleForm(this.todoDocument, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref){
    Todo todo = todoDocument.todo!;
    String todoId = todoDocument.docId!;
    return SizedBox();
  }
}