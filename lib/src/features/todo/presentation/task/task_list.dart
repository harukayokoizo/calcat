import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:share_calendar/src/features/todo/application/todo_provider.dart';
import 'package:share_calendar/src/features/todo/domain/todo_document.dart';
import 'package:share_calendar/src/features/todo/presentation/task/task_list_widget.dart';
import '../../application/task_provider.dart';
import '../../data/task_repositories.dart';
import '../../domain/task_document.dart';
import '../../domain/todo.dart';
import '../todo/todo_title_form.dart';


class TaskList extends ConsumerWidget{
  final TodoDocument todoDocument;
  const TaskList(this.todoDocument, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todoDoc = ref.watch(todoProvider(todoDocument));
    final taskList = ref.watch(taskListProvider(todoDocument));
    return taskList.when(
      error: (err, _) => const SizedBox(), //エラー時
      loading: () => const SizedBox(), //読み込み時
      data: (tasks){
        return Padding(
          padding: const EdgeInsets.only(left: 20, top: 0.0, right: 20.0, bottom: 0.0),
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: todoDoc.when(
                  error: (err, _) => const SizedBox(), //エラー時
                  loading: () => const SizedBox(), //読み込み時
                  data: (todo){
                    return TodoTitleForm(todo);
                  },
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
                    if(tasks.isNotEmpty) {
                      return TaskListForm(tasks[index], index, tasks.length, ref);
                    }else{
                      return const SizedBox();
                    }
                  },
                  childCount: tasks.length,
                ),
              ),
            ],
          ),
        );
      }, //データ受け取り時
    );
  }
}


class TaskListForm extends StatefulWidget{
  final TaskDocument taskDocument;
  final int index;
  final int length;
  final WidgetRef ref;
  const TaskListForm(this.taskDocument, this.index, this.length, this.ref, {super.key});

  @override
  State<TaskListForm> createState() => TaskListFormState();
}

class TaskListFormState extends State<TaskListForm> with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return SlidableAutoCloseBehavior(
      child: Slidable(
          // key: ValueKey(widget.index),
          endActionPane: ActionPane(
            extentRatio: 0.25,
            motion: const ScrollMotion(),
            children: [
              SlidableAction(
                onPressed: (_) {
                  widget.ref.read(taskRepositories).deleteTask(widget.taskDocument);
                },
                backgroundColor: Colors.red,
                //foregroundColor: Colors.red,
                icon: Icons.delete,
                label: '削除',
              ),
            ],
          ),
          child: TaskListFormWidget(widget.taskDocument, widget.index, widget.length)),
    );
  }
}