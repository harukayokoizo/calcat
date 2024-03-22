// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../calendar/domain/calendar_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CalendarUserImpl _$$CalendarUserImplFromJson(Map<String, dynamic> json) =>
    _$CalendarUserImpl(
      uid: json['uid'] as String?,
      calendar: _$JsonConverterFromJson<DocumentReference<Object?>,
              DocumentReference<Object?>>(
          json['calendar'], const DocumentReferenceConverter().fromJson),
      create: _$JsonConverterFromJson<Timestamp, DateTime>(
          json['create'], const TimestampConverter().fromJson),
    );

Map<String, dynamic> _$$CalendarUserImplToJson(_$CalendarUserImpl instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'calendar': _$JsonConverterToJson<DocumentReference<Object?>,
              DocumentReference<Object?>>(
          instance.calendar, const DocumentReferenceConverter().toJson),
      'create': _$JsonConverterToJson<Timestamp, DateTime>(
          instance.create, const TimestampConverter().toJson),
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
