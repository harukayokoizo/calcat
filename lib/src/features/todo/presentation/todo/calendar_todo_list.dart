import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_calendar/src/features/calendar/domain/calendar_document.dart';
import 'package:share_calendar/src/features/todo/domain/todo_document.dart';
import 'package:share_calendar/src/features/todo/presentation/todo/todo_list_widget.dart';

import '../../../calendar/domain/calendar.dart';
import '../../application/todo_provider.dart';
import '../../data/todo_repositories.dart';


class CalendarTodoList extends ConsumerWidget{
  final CalendarDocument calendarDocument;
  const CalendarTodoList(this.calendarDocument, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String calendarId = calendarDocument.docId!;
    final todoList = ref.watch(todoListProvider(calendarId));
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            size: 26,
            color: Colors.black.withOpacity(0.5),
          ),
        ),
        title: Text(
          'Todoリスト',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black.withOpacity(0.5),
          ),
        ),
        backgroundColor: const Color(0xFFACC5DB),
      ),
      body: todoList.when(
        error: (err, _) => const SizedBox(), //エラー時
        loading: () => const SizedBox(), //読み込み時
        data: (todos){
          if(todos.isNotEmpty) {
            return CustomScrollView(
              slivers: [
                SliverList(
                  delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.only(left: 20, top: 15.0, right: 20.0, bottom: 0.0),
                      child: TodoListWidget(todos[index]),
                    );
                  },
                    childCount: todos.length
                  ),
                ),
              ],
            );
          }else{
            return const SizedBox();
          }
        }, //データ受け取り時
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue.shade500,
        shape: const CircleBorder(),
        heroTag: "search",
        child: const Icon(Icons.add, color: Colors.white),
        onPressed: () async {
          await ref.read(todoRepositories).createTodo(calendarId);
        },

      ),
    );
  }

}