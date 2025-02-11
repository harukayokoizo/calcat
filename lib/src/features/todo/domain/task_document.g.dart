// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_document.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TaskDocumentImpl _$$TaskDocumentImplFromJson(Map<String, dynamic> json) =>
    _$TaskDocumentImpl(
      task: json['task'] == null
          ? null
          : Task.fromJson(json['task'] as Map<String, dynamic>),
      docId: json['docId'] as String?,
    );

Map<String, dynamic> _$$TaskDocumentImplToJson(_$TaskDocumentImpl instance) =>
    <String, dynamic>{
      'task': instance.task,
      'docId': instance.docId,
    };
