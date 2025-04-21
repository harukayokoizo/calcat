import 'package:isar/isar.dart';
part 'local_task.g.dart';

@collection
class LocalTask {
  Id? id = Isar.autoIncrement;
  String? task;
  bool? check;
  DateTime? updated;

  @Index()
  DateTime? created;
}