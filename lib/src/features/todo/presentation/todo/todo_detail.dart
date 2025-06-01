import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_calendar/src/features/todo/presentation/task/task_list.dart';

import '../../data/task_repositories.dart';
import '../../domain/todo.dart';
import '../../domain/todo_document.dart';
import '../common/todo_popup_menu.dart';

class TodoDetail extends ConsumerStatefulWidget {
  final TodoDocument todoDocument;
  const TodoDetail(this.todoDocument, {super.key});

  @override
  ConsumerState<TodoDetail> createState() => TodoDetailState();
}

class TodoDetailState extends ConsumerState<TodoDetail>{
  late bool tap;

  @override
  void initState() {
    super.initState();
    tap = false;
  }

  @override
  Widget build(BuildContext context){
    Todo todo = widget.todoDocument.todo!;
    String todoId = widget.todoDocument.docId!;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFACC5DB),
        leadingWidth: 200,
        leading: Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: GestureDetector(
            onTapDown: (TapDownDetails details){
              setState(() {
                tap = true;
              });
            },
            onTapUp: (TapUpDetails details){
              Navigator.pop(context);
            },
            onPanUpdate: (DragUpdateDetails details) {
              setState(() {
                tap = false;
              });
            },
            child: Align(
              alignment: Alignment.centerLeft,
              child: RichText(
                text: TextSpan(
                  children: [
                    WidgetSpan(
                      child: Icon(
                        Icons.arrow_back_ios,
                        size: 20,
                        color: Colors.black.withOpacity(0.5),
                      ),
                    ),
                    TextSpan(
                      text: 'Todoリスト',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.black.withOpacity(0.5),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TodoPopupMenu(widget.todoDocument),
          ),
        ],
      ),
      body: TaskList(widget.todoDocument),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue.shade500,
        shape: const CircleBorder(),
        heroTag: "search",
        child: const Icon(Icons.add, color: Colors.white),
        onPressed: () async {
          await ref.read(taskRepositories).createTask(todo.calendarId!, todoId);
        },

      ),
    );
  }
}