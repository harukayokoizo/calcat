import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_calendar/src/features/todo/domain/task.dart';

import '../../../common_widgets/application/common_provider.dart';
import '../domain/task_document.dart';

final taskRepositories = Provider.autoDispose((ref) => TaskRepositories(ref));

class TaskRepositories {
  Ref ref;

  TaskRepositories(this.ref);

  //Taskのリアルタイム取得
  Stream<List<TaskDocument>> getTodoList(String calendarId, String todoId) async*{
    try {
      final tasks = FirebaseFirestore.instance
          .collection('calendar')
          .doc(calendarId)
          .collection('todo')
          .doc(todoId)
          .collection('task')
          .orderBy('updated', descending: true)
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
  Future<void> createCalendar(String calendarId, String todoId) async{
    try {
      final user = ref.read(currentUserProvider);
      DateTime date = DateTime.now();
      Map<String, dynamic> data = {
        'task': '',
        'user': user!.uid,
        'check': false,
        'created': false,
        'updated': date,
        'todoId': todoId,
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
  Future<void> getCalendarOwner(TaskDocument task, Map<String, dynamic> data) async{
    try {
      // await FirebaseFirestore.instance
      //     .collection('calendar')
      //     .doc(calendarId)
      //     .collection('todo')
      //     .doc(todoId)
      //     .collection('task')
      //     .doc(taskId)
      //     .update(data);

    }catch (e){
      throw e.toString();
    }
  }

  //Todoの削除処理
  Future<void> deleteCalendar(String todoId) async{
    // await FirebaseFirestore.instance
    //     .collection('calendar')
    //     .doc(calendarId)
    //     .collection('todo')
    //     .doc(todoId)
    //     .collection('task')
    //     .doc(taskId)
    //     .delete();
  }
}