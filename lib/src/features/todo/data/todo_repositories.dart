import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_calendar/src/features/todo/data/task_repositories.dart';

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
          .collection('todo')
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

  Stream<TodoDocument> getTodo(TodoDocument todoDocument) async*{
    try {
      final todo = todoDocument.todo;
      final todoDoc = FirebaseFirestore.instance
          .collection('calendar')
          .doc(todo!.calendarId)
          .collection('todo')
          .doc(todoDocument.docId)
          .snapshots()
          .map((e){
            var todo = Todo.fromJson(e.data()!);
            var todoDoc = TodoDocument(todo: todo, docId: e.id);
            return todoDoc;
          });

      yield* todoDoc;
    }catch (e){
      throw e.toString();
    }
  }

  //Todoの作成処理
  Future<void> createTodo(String calendarId) async{
    try {
      final user = ref.read(currentUserProvider);
      DateTime date = DateTime.now();
      Map<String, dynamic> data = {
        'author': user!.uid,
        'title': '',
        'pin': false,
        'complete': false,
        'updated': date,
        'calendarId': calendarId,
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
  Future<void> updateTodo(TodoDocument todoDocument, Map<String, dynamic> data) async{
    try {
      final todo = todoDocument.todo;
      await FirebaseFirestore.instance
          .collection('calendar')
          .doc(todo!.calendarId)
          .collection('todo')
          .doc(todoDocument.docId)
          .update(data);

    }catch (e){
      throw e.toString();
    }
  }

  //Todoの削除処理
  Future<void> deleteTodo(TodoDocument todoDocument) async{
    try {
      final todo = todoDocument.todo;

      await ref.read(taskRepositories).deleteAllTask(todoDocument);

      await FirebaseFirestore.instance
          .collection('calendar')
          .doc(todo!.calendarId)
          .collection('todo')
          .doc(todoDocument.docId)
          .delete();

    }catch (e){
      throw e.toString();
    }
  }
}