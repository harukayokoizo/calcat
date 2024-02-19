// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'personal_event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PersonalEventImpl _$$PersonalEventImplFromJson(Map<String, dynamic> json) =>
    _$PersonalEventImpl(
      uid: json['uid'] as String?,
      title: json['title'] as String?,
      event: json['event'] as String?,
      image: json['image'] as String?,
      color: json['color'] as String?,
      isAllDay: json['isAllDay'] as bool?,
      from: _$JsonConverterFromJson<Timestamp, DateTime>(
          json['from'], const TimestampConverter().fromJson),
      to: _$JsonConverterFromJson<Timestamp, DateTime>(
          json['to'], const TimestampConverter().fromJson),
      sameEventId: json['sameEventId'] as String?,
      number: json['number'] as int?,
    );

Map<String, dynamic> _$$PersonalEventImplToJson(_$PersonalEventImpl instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'title': instance.title,
      'event': instance.event,
      'image': instance.image,
      'color': instance.color,
      'isAllDay': instance.isAllDay,
      'from': _$JsonConverterToJson<Timestamp, DateTime>(
          instance.from, const TimestampConverter().toJson),
      'to': _$JsonConverterToJson<Timestamp, DateTime>(
          instance.to, const TimestampConverter().toJson),
      'sameEventId': instance.sameEventId,
      'number': instance.number,
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
