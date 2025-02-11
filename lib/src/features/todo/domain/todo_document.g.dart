// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo_document.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TodoDocumentImpl _$$TodoDocumentImplFromJson(Map<String, dynamic> json) =>
    _$TodoDocumentImpl(
      todo: json['todo'] == null
          ? null
          : Todo.fromJson(json['todo'] as Map<String, dynamic>),
      docId: json['docId'] as String?,
    );

Map<String, dynamic> _$$TodoDocumentImplToJson(_$TodoDocumentImpl instance) =>
    <String, dynamic>{
      'todo': instance.todo,
      'docId': instance.docId,
    };
