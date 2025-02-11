import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_calendar/src/features/todo/presentation/task/task_list.dart';

import '../../data/todo_repositories.dart';
import '../../domain/todo.dart';
import '../../domain/todo_document.dart';

class TodoTitleForm extends ConsumerStatefulWidget{
  final TodoDocument todoDocument;
  const TodoTitleForm(this.todoDocument, {super.key});

  @override
  ConsumerState<TodoTitleForm> createState() => TodoTitleFormState();
}

class TodoTitleFormState extends ConsumerState<TodoTitleForm>{
  late TextEditingController controller = TextEditingController();
  final FocusNode focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    focusNode.addListener(() {
      if (!focusNode.hasFocus) {
        DateTime date = DateTime.now();
        Map<String, dynamic> data = {'title': controller.value.text, 'updated': date};
        ref.read(todoRepositories).updateTodo(widget.todoDocument, data);
      }
    });
  }

  @override
  Widget build(BuildContext context){
    controller.text = widget.todoDocument.todo!.title!;
    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      maxLines: null,
      style: const TextStyle(
        fontSize: 20,
      ),
      decoration: const InputDecoration(
        hintText: 'タイトル',
        border: InputBorder.none,
      ),
      onTapOutside: (value){
        focusNode.unfocus();
      },
      onFieldSubmitted: (value){
        DateTime date = DateTime.now();
        Map<String, dynamic> data = {'title': controller.value.text, 'updated': date};
        ref.read(todoRepositories).updateTodo(widget.todoDocument, data);
      },
    );
  }
}