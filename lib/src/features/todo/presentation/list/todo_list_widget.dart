import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TodoListWidget extends StatelessWidget{
  const TodoListWidget({super.key});

  @override
  Widget build(BuildContext context){
    final double deviceWidth = MediaQuery.of(context).size.width;
    return Container(
      height: 100,
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
              height: 100,
              width: 100,
              child: TodoContents(),
            );
          }
      ),
    );
  }
}

Widget TodoContents(){
  return Text('Todo');
}