// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'calendar_document.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CalendarDocumentImpl _$$CalendarDocumentImplFromJson(
        Map<String, dynamic> json) =>
    _$CalendarDocumentImpl(
      calendar: json['calendar'] == null
          ? null
          : Calendar.fromJson(json['calendar'] as Map<String, dynamic>),
      docId: json['docId'] as String?,
    );

Map<String, dynamic> _$$CalendarDocumentImplToJson(
        _$CalendarDocumentImpl instance) =>
    <String, dynamic>{
      'calendar': instance.calendar,
      'docId': instance.docId,
    };
