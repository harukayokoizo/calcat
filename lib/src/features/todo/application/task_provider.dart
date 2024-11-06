import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/task_repositories.dart';
import '../data/todo_repositories.dart';
import '../domain/task_document.dart';
import '../domain/todo_document.dart';

final taskListProvider = StreamProvider.autoDispose.family<List<TaskDocument>, TodoDocument>(
      (ref, todoDocument) {
        final todoId = todoDocument.docId!;
        final calendarId = todoDocument.todo!.calendarId!;
        var calendarDoc = ref.read(taskRepositories).getTaskList(calendarId, todoId);
        return calendarDoc;
      },
);