import 'package:freezed_annotation/freezed_annotation.dart';
import 'todo.dart';

part 'todo_document.freezed.dart';
part 'todo_document.g.dart';

@freezed
abstract class TodoDocument with _$TodoDocument{
  const factory TodoDocument({
    Todo? todo,
    String? docId
  }) = _TodoDocument;

  factory TodoDocument.fromJson(Map<String,dynamic> json) => _$TodoDocumentFromJson(json);
}