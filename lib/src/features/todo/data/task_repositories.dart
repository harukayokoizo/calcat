import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_calendar/src/features/todo/domain/task.dart';

import '../../../common_widgets/application/common_provider.dart';
import '../domain/task_document.dart';
import '../domain/todo_document.dart';

final taskRepositories = Provider.autoDispose((ref) => TaskRepositories(ref));

class TaskRepositories {
  Ref ref;

  TaskRepositories(this.ref);

  //Taskのリアルタイム取得
  Stream<List<TaskDocument>> getTaskList(String calendarId, String todoId) async*{
    try {
      final tasks = FirebaseFirestore.instance
          .collection('calendar')
          .doc(calendarId)
          .collection('todo')
          .doc(todoId)
          .collection('task')
          .orderBy('created', descending: false)
          .snapshots()
          .map((snapshots) =>
          snapshots.docs.map((e) {
            var task = Task.fromJson(e.data());
            var taskDoc = TaskDocument(task: task, docId: e.id);
            return taskDoc;
          }).toList());

      yield* tasks;
    }catch (e){
      throw e.toString();
    }
  }

  //Todoの作成処理
  Future<void> createTask(String calendarId, String todoId) async{
    try {
      final user = ref.read(currentUserProvider);
      DateTime date = DateTime.now();
      Map<String, dynamic> data = {
        'task': '',
        'user': user!.uid,
        'check': false,
        'created': date,
        'updated': date,
        'todoId': todoId,
        'calendarId': calendarId,
      };

      await FirebaseFirestore.instance
          .collection('calendar')
          .doc(calendarId)
          .collection('todo')
          .doc(todoId)
          .collection('task')
          .add(data);

    }catch (e){
      throw e.toString();
    }
  }

  //Todoの更新処理 (Todo詳細画面から更新する)
  Future<void> updateTask(TaskDocument taskDocument, Map<String, dynamic> data) async{
    try {
      final task = taskDocument.task;
      await FirebaseFirestore.instance
          .collection('calendar')
          .doc(task!.calendarId)
          .collection('todo')
          .doc(task.todoId)
          .collection('task')
          .doc(taskDocument.docId)
          .update(data);

    }catch (e){
      throw e.toString();
    }
  }

  //Todoの削除処理
  Future<void> deleteTask(TaskDocument taskDocument) async{
    final task = taskDocument.task;
    await FirebaseFirestore.instance
        .collection('calendar')
        .doc(task!.calendarId)
        .collection('todo')
        .doc(task.todoId)
        .collection('task')
        .doc(taskDocument.docId)
        .delete();
  }

  Future<void> deleteNoneTitleTask(TodoDocument todoDocument) async{
    final todo = todoDocument.todo;
    final tasks = await FirebaseFirestore.instance
        .collection('calendar')
        .doc(todo!.calendarId)
        .collection('todo')
        .doc(todoDocument.docId)
        .collection('task')
        .where('task', isEqualTo: "")
        .get();

    if(tasks.docs.isNotEmpty){
      for (var doc in tasks.docs) {
        await doc.reference.delete();
      }
    }
  }

  Future<void> deleteAllTask(TodoDocument todoDocument) async{
    final todo = todoDocument.todo;
    final tasks = await FirebaseFirestore.instance
        .collection('calendar')
        .doc(todo!.calendarId)
        .collection('todo')
        .doc(todoDocument.docId)
        .collection('task')
        .get();

    if(tasks.docs.isNotEmpty){
      for (var doc in tasks.docs) {
        await doc.reference.delete();
      }
    }
  }
}