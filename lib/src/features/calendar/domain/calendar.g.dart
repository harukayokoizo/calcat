// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'calendar.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CalendarImpl _$$CalendarImplFromJson(Map<String, dynamic> json) =>
    _$CalendarImpl(
      author: json['author'] as String?,
      title: json['title'] as String?,
      description: json['description'] as String?,
      image: json['image'] as String?,
      publicPreference: json['publicPreference'] as bool?,
      password: json['password'] as String?,
      created: _$JsonConverterFromJson<Timestamp, DateTime>(
          json['created'], const TimestampConverter().fromJson),
      updated: _$JsonConverterFromJson<Timestamp, DateTime>(
          json['updated'], const TimestampConverter().fromJson),
      searchIndex: (json['searchIndex'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$$CalendarImplToJson(_$CalendarImpl instance) =>
    <String, dynamic>{
      'author': instance.author,
      'title': instance.title,
      'description': instance.description,
      'image': instance.image,
      'publicPreference': instance.publicPreference,
      'password': instance.password,
      'created': _$JsonConverterToJson<Timestamp, DateTime>(
          instance.created, const TimestampConverter().toJson),
      'updated': _$JsonConverterToJson<Timestamp, DateTime>(
          instance.updated, const TimestampConverter().toJson),
      'searchIndex': instance.searchIndex,
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
