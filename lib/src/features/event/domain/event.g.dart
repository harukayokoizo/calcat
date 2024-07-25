// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$EventImpl _$$EventImplFromJson(Map<String, dynamic> json) => _$EventImpl(
      uid: json['uid'] as String?,
      title: json['title'] as String?,
      overview: json['overview'] as String?,
      image: json['image'] as String?,
      color: (json['color'] as num?)?.toInt(),
      url: json['url'] as String?,
      location: json['location'] as String?,
      isAllDay: json['isAllDay'] as bool?,
      from: _$JsonConverterFromJson<Timestamp, DateTime>(
          json['from'], const TimestampConverter().fromJson),
      to: _$JsonConverterFromJson<Timestamp, DateTime>(
          json['to'], const TimestampConverter().fromJson),
      repeat: (json['repeat'] as num?)?.toInt(),
      endDate: _$JsonConverterFromJson<Timestamp, DateTime>(
          json['endDate'], const TimestampConverter().fromJson),
      createdAt: _$JsonConverterFromJson<Timestamp, DateTime>(
          json['createdAt'], const TimestampConverter().fromJson),
      updatedAt: _$JsonConverterFromJson<Timestamp, DateTime>(
          json['updatedAt'], const TimestampConverter().fromJson),
      sameEventId: json['sameEventId'] as String?,
      number: (json['number'] as num?)?.toInt(),
      calendarId: json['calendarId'] as String?,
      notificationExist: json['notificationExist'] as bool?,
      calendarMonth: json['calendarMonth'] as String?,
    );

Map<String, dynamic> _$$EventImplToJson(_$EventImpl instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'title': instance.title,
      'overview': instance.overview,
      'image': instance.image,
      'color': instance.color,
      'url': instance.url,
      'location': instance.location,
      'isAllDay': instance.isAllDay,
      'from': _$JsonConverterToJson<Timestamp, DateTime>(
          instance.from, const TimestampConverter().toJson),
      'to': _$JsonConverterToJson<Timestamp, DateTime>(
          instance.to, const TimestampConverter().toJson),
      'repeat': instance.repeat,
      'endDate': _$JsonConverterToJson<Timestamp, DateTime>(
          instance.endDate, const TimestampConverter().toJson),
      'createdAt': _$JsonConverterToJson<Timestamp, DateTime>(
          instance.createdAt, const TimestampConverter().toJson),
      'updatedAt': _$JsonConverterToJson<Timestamp, DateTime>(
          instance.updatedAt, const TimestampConverter().toJson),
      'sameEventId': instance.sameEventId,
      'number': instance.number,
      'calendarId': instance.calendarId,
      'notificationExist': instance.notificationExist,
      'calendarMonth': instance.calendarMonth,
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
