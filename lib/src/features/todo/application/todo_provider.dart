import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/todo_repositories.dart';
import '../domain/todo_document.dart';

final todoListProvider = StreamProvider.autoDispose.family<List<TodoDocument>, String>(
      (ref, calendarId) {
        var todoList = ref.read(todoRepositories).getTodoList(calendarId);
        return todoList;
        },
);

final todoProvider = StreamProvider.autoDispose.family<TodoDocument, TodoDocument>(
            (ref, todoDocument) {
                var todoDoc = ref.read(todoRepositories).getTodo(todoDocument);
                return todoDoc;
        },
);