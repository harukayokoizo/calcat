import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_calendar/src/features/todo/presentation/list/todo_list_widget.dart';


class CalendarTodoList extends ConsumerWidget{
  const CalendarTodoList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('メモ'),),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, top: 15.0, right: 20.0, bottom: 0.0),
        child: TodoListWidget(),
      ),
    );
  }

}