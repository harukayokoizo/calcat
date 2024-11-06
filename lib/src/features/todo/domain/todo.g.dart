// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TodoImpl _$$TodoImplFromJson(Map<String, dynamic> json) => _$TodoImpl(
      author: json['author'] as String?,
      title: json['title'] as String?,
      pin: json['pin'] as bool?,
      complete: json['complete'] as bool?,
      updated: _$JsonConverterFromJson<Timestamp, DateTime>(
          json['updated'], const TimestampConverter().fromJson),
      calendarId: json['calendarId'] as String?,
    );

Map<String, dynamic> _$$TodoImplToJson(_$TodoImpl instance) =>
    <String, dynamic>{
      'author': instance.author,
      'title': instance.title,
      'pin': instance.pin,
      'complete': instance.complete,
      'updated': _$JsonConverterToJson<Timestamp, DateTime>(
          instance.updated, const TimestampConverter().toJson),
      'calendarId': instance.calendarId,
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
