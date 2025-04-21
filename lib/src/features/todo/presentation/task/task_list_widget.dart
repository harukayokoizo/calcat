import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../../../event/application/datetime_format.dart';
import '../../data/task_repositories.dart';
import '../../data/todo_repositories.dart';
import '../../domain/task.dart';
import '../../domain/task_document.dart';
import '../../domain/todo.dart';
import '../../domain/todo_document.dart';
import '../todo/todo_detail.dart';

class TaskListFormWidget extends ConsumerStatefulWidget{
  final TodoDocument todoDocument;
  final TaskDocument taskDocument;
  final int index;
  final int length;
  const TaskListFormWidget(this.todoDocument, this.taskDocument, this.index, this.length, {super.key});

  @override
  ConsumerState<TaskListFormWidget> createState() => TaskListFormWidgetState();
}

class TaskListFormWidgetState extends ConsumerState<TaskListFormWidget>{
  late TextEditingController controller = TextEditingController();
  final FocusNode focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    focusNode.addListener(() {
      if (!focusNode.hasFocus) {
        DateTime date = DateTime.now();
        Map<String, dynamic> task = {'task': controller.value.text, 'updated': date};
        Map<String, dynamic> todo = {'updated': date};
        ref.read(taskRepositories).updateTask(widget.taskDocument, task);
        ref.read(todoRepositories).updateTodo(widget.todoDocument, todo);
      }
    });
  }

  @override
  Widget build(BuildContext context){
    Task task = widget.taskDocument.task!;
    controller.text = task.task!;
    final double deviceWidth = MediaQuery.of(context).size.width;
    return Container(
      width: deviceWidth,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: const BorderSide(
              color: Color(0xFFEDEDED), width: 1.0),
          left: const BorderSide(
              color: Color(0xFFEDEDED), width: 1.0),
          right: const BorderSide(
              color: Color(0xFFEDEDED), width: 1.0),
          bottom: widget.index == widget.length - 1 ? const BorderSide(
              color: Color(0xFFEDEDED), width: 1.0) : BorderSide
              .none,
        ),
        borderRadius: BorderRadius.only(
          topLeft: widget.index == 0
              ? const Radius.circular(10)
              : const Radius.circular(0),
          topRight: widget.index == 0
              ? const Radius.circular(10)
              : const Radius.circular(0),
          bottomLeft: widget.index == widget.length - 1 ? const Radius
              .circular(10) : const Radius.circular(0),
          bottomRight: widget.index == widget.length - 1 ? const Radius
              .circular(10) : const Radius.circular(0),
        ),
      ),
      child: LayoutBuilder(
          builder: (context, constraints) {
            return Row(
              children: [
                Transform.scale(
                  scale: 1.0,
                  child: Checkbox(
                    side: const BorderSide(color: Colors.grey, width: 1),
                    value: task.check,
                    onChanged: (value){
                      DateTime date = DateTime.now();
                      var data = {'check': value, 'updated': date};
                      ref.read(taskRepositories).updateTask(widget.taskDocument, data);
                    },
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 30.0),
                    child: TextFormField(
                      controller: controller,
                      focusNode: focusNode,
                      maxLines: null,
                      decoration: const InputDecoration(
                        hintText: 'タスク',
                        border: InputBorder.none,
                      ),
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                      ),
                      onTapOutside: (value){
                        focusNode.unfocus();
                      },
                      onFieldSubmitted: (value){
                        DateTime date = DateTime.now();
                        Map<String, dynamic> task = {'task': value, 'updated': date};
                        Map<String, dynamic> todo = {'updated': date};
                        ref.read(taskRepositories).updateTask(widget.taskDocument, task);
                        ref.read(todoRepositories).updateTodo(widget.todoDocument, todo);
                      },
                    ),
                  ),
                ),
              ],
            );
          }
      ),
    );
  }
}