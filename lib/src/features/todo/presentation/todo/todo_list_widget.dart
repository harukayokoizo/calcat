import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../event/application/datetime_format.dart';
import '../../data/task_repositories.dart';
import '../../domain/todo.dart';
import '../../domain/todo_document.dart';
import 'todo_detail.dart';

class TodoListWidget extends ConsumerWidget{
  final TodoDocument todoDocument;
  const TodoListWidget(this.todoDocument, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref){
    Todo todo = todoDocument.todo!;
    String todoId = todoDocument.docId!;
    final double deviceWidth = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TodoDetail(todoDocument),
          ),
        ).then((value){
          ref.read(taskRepositories).deleteNoneTitleTask(todoDocument);
        });
      },
      child: Container(
        height: 80,
        width: deviceWidth,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: const Border(
            top: BorderSide(color: Color(0xFFDCDCDC), width: 1.0),
            right: BorderSide(color: Color(0xFFDCDCDC), width: 1.0),
            bottom: BorderSide(color: Color(0xFFDCDCDC), width: 1.0),
            left: BorderSide(color: Color(0xFFDCDCDC), width: 1.0),
          ),
        ),
        child: LayoutBuilder(
            builder: (context, constraints) {
              return SizedBox(
                height: 100,
                width: 100,
                child: Padding(
                  padding: const EdgeInsets.only(left: 16.0, top: 12.0, right: 16.0, bottom: 12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        flex: 2,
                        child: todoTitle(todo.title!),
                      ),
                      Flexible(
                        flex: 1,
                        child: todoUpdated(todo.updated!),
                      ),
                    ],
                  ),
                ),
              );
            }
        ),
      ),
    );
  }
}

Widget todoTitle(String title){
  final text = title.isEmpty ? '新規Todo' : title;
  return Text(
    text,
    style: const TextStyle(
      fontSize: 20
    ),
  );
}

Widget todoUpdated(DateTime date){
  final dateTimeFormat = DateTimeFormat(date);
  return Text(
    dateTimeFormat.dateNormalFormat(),
    style: const TextStyle(
        fontSize: 12,
      color: Colors.grey
    ),
  );
}