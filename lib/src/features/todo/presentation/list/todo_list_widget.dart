import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../event/application/datetime_format.dart';
import '../../domain/todo.dart';
import '../../domain/todo_document.dart';
import '../detail/todo_detail.dart';

class TodoListWidget extends StatelessWidget{
  final TodoDocument todoDocument;
  const TodoListWidget(this.todoDocument, {super.key});

  @override
  Widget build(BuildContext context){
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
        );
      },
      child: Container(
        height: 80,
        width: deviceWidth,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.7), // 影の色
              spreadRadius: 1, // スプレッド半径
              blurRadius: 2, // ぼかし半径
              offset: const Offset(0, 1), // オフセット（x, y）
            ),
          ],
        ),
        child: LayoutBuilder(
            builder: (context, constraints) {
              return SizedBox(
                height: 80,
                width: 100,
                child: Padding(
                  padding: const EdgeInsets.only(left: 16.0, top: 12.0, right: 16.0, bottom: 12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      todoTitle(todo.title!),
                      todoUpdated(todo.updated!),
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
  final text = title.isEmpty ? '新規メモ' : title;
  return Text(
    text,
    style: const TextStyle(
      fontSize: 18
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