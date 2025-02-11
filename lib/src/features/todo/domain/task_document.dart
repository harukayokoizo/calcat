import 'package:freezed_annotation/freezed_annotation.dart';
import 'task.dart';

part 'task_document.freezed.dart';
part 'task_document.g.dart';

@freezed
abstract class TaskDocument with _$TaskDocument{
  const factory TaskDocument({
    Task? task,
    String? docId
  }) = _TaskDocument;

  factory TaskDocument.fromJson(Map<String,dynamic> json) => _$TaskDocumentFromJson(json);
}