import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/todo_repositories.dart';
import '../domain/todo_document.dart';

final todoListProvider = StreamProvider.autoDispose.family<List<TodoDocument>, String>(
      (ref, calendarId) {
        var calendarDoc = ref.read(todoRepositories).getTodoList(calendarId);
        return calendarDoc;
        },
);