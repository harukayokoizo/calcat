import 'package:isar/isar.dart';
part 'local_todo.g.dart';

@collection
class LocalTodo {
  Id? id = Isar.autoIncrement;
  String? title;
  bool? pin;
  bool? complete;

  @Index()
  DateTime? updated;
}