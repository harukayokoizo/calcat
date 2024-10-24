// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TaskImpl _$$TaskImplFromJson(Map<String, dynamic> json) => _$TaskImpl(
      task: json['task'] as String?,
      user: json['user'] as String?,
      check: json['check'] as bool?,
      created: _$JsonConverterFromJson<Timestamp, DateTime>(
          json['created'], const TimestampConverter().fromJson),
      updated: _$JsonConverterFromJson<Timestamp, DateTime>(
          json['updated'], const TimestampConverter().fromJson),
      todoId: json['todoId'] as String?,
    );

Map<String, dynamic> _$$TaskImplToJson(_$TaskImpl instance) =>
    <String, dynamic>{
      'task': instance.task,
      'user': instance.user,
      'check': instance.check,
      'created': _$JsonConverterToJson<Timestamp, DateTime>(
          instance.created, const TimestampConverter().toJson),
      'updated': _$JsonConverterToJson<Timestamp, DateTime>(
          instance.updated, const TimestampConverter().toJson),
      'todoId': instance.todoId,
    };

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) =>
    json == null ? null : fromJson(json as Json);

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) =>
    value == null ? null : toJson(value);
