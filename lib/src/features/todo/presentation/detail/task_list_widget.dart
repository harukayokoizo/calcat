import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../event/application/datetime_format.dart';
import '../../domain/task.dart';
import '../../domain/task_document.dart';
import '../../domain/todo.dart';
import '../../domain/todo_document.dart';
import '../detail/todo_detail.dart';

class TaskListWidget extends StatelessWidget{
  final TaskDocument taskDocument;
  final int index;
  final int length;
  const TaskListWidget(this.taskDocument, this.index, this.length, {super.key});

  @override
  Widget build(BuildContext context){
    Task task = taskDocument.task!;
    String todoId = taskDocument.docId!;
    final double deviceWidth = MediaQuery.of(context).size.width;
    return Container(
      width: deviceWidth,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: const BorderSide(
              color: Color(0xFFF5F5F5), width: 1.0),
          left: const BorderSide(
              color: Color(0xFFF5F5F5), width: 1.0),
          right: const BorderSide(
              color: Color(0xFFF5F5F5), width: 1.0),
          bottom: index == length - 1 ? const BorderSide(
              color: Color(0xFFF5F5F5), width: 1.0) : BorderSide
              .none,
        ),
        borderRadius: BorderRadius.only(
          topLeft: index == 0
              ? const Radius.circular(10)
              : const Radius.circular(0),
          topRight: index == 0
              ? const Radius.circular(10)
              : const Radius.circular(0),
          bottomLeft: index == length - 1 ? const Radius
              .circular(10) : const Radius.circular(0),
          bottomRight: index == length - 1 ? const Radius
              .circular(10) : const Radius.circular(0),
        ),
      ),
      child: LayoutBuilder(
          builder: (context, constraints) {
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: SizedBox(
                width: constraints.maxWidth * 0.8,
                child: Text(
                  task.task!,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                  ),
                ),
              ),
            );
          }
      ),
    );
  }
}