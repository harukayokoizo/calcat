import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_calendar/src/features/calendar/domain/calendar_document.dart';
import 'package:share_calendar/src/features/todo/domain/todo_document.dart';
import 'package:share_calendar/src/features/todo/presentation/detail/task_list_widget.dart';
import 'package:share_calendar/src/features/todo/presentation/list/todo_list_widget.dart';

import '../../../calendar/domain/calendar.dart';
import '../../application/task_provider.dart';
import '../../application/todo_provider.dart';
import '../../data/todo_repositories.dart';
import '../../domain/todo.dart';


class TaskList extends ConsumerWidget{
  final TodoDocument todoDocument;
  const TaskList(this.todoDocument, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Todo todo = todoDocument.todo!;
    String todoId = todoDocument.docId!;
    final taskList = ref.watch(taskListProvider(todoDocument));
    return taskList.when(
      error: (err, _) => const SizedBox(), //エラー時
      loading: () => const SizedBox(), //読み込み時
      data: (tasks){
        if(tasks.isNotEmpty) {
          return CustomScrollView(
            slivers: [
              SliverList(
                delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 20, top: 15.0, right: 20.0, bottom: 0.0),
                    child: TaskListWidget(tasks[index], index, tasks.length),
                  );
                },
                  childCount: tasks.length,
                ),
              ),
            ],
          );
        }else{
          return const SizedBox();
        }
      }, //データ受け取り時
    );
  }

}