import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../common_widgets/application/common_provider.dart';
import '../domain/todo.dart';
import '../domain/todo_document.dart';

final todoRepositories = Provider.autoDispose((ref) => TodoRepositories(ref));

class TodoRepositories {
  Ref ref;

  TodoRepositories(this.ref);

  //Todoのリアルタイム取得
  Stream<List<TodoDocument>> getTodoList(String calendarId) async*{
    try {
      final todos = FirebaseFirestore.instance
          .collection('calendar')
          .doc(calendarId)
          .collection('calendar')
          .orderBy('updated', descending: true)
          .snapshots()
          .map((snapshots) =>
            snapshots.docs.map((e) {
              var todo = Todo.fromJson(e.data());
              var todoDoc = TodoDocument(todo: todo, docId: e.id);
              return todoDoc;
            }).toList());

      yield* todos;
    }catch (e){
      throw e.toString();
    }
  }

  //Todoの作成処理
  Future<void> createCalendar(String calendarId) async{
    try {
      final user = ref.read(currentUserProvider);
      DateTime date = DateTime.now();
      Map<String, dynamic> data = {
        'author': user!.uid,
        'title': '',
        'pin': false,
        'complete': false,
        'updated': date,
      };

      await FirebaseFirestore.instance
          .collection('calendar')
          .doc(calendarId)
          .collection('todo')
          .add(data);

    }catch (e){
      throw e.toString();
    }
  }

  //Todoの更新処理 (Todo詳細画面から更新する)
  Future<void> getCalendarOwner(TodoDocument todo, Map<String, dynamic> data) async{
    try {
      final user = ref.read(currentUserProvider);
      // final calendarDoc = await FirebaseFirestore.instance
      //     .collection('calendar')
      //     .doc(calendarId)
      //     .collection('todo')
      //     .doc(todo);

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
    //     .delete();
  }
}