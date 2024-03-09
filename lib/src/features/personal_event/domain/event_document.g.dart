// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_document.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$EventDocumentImpl _$$EventDocumentImplFromJson(Map<String, dynamic> json) =>
    _$EventDocumentImpl(
      event: json['event'] == null
          ? null
          : PersonalEvent.fromJson(json['event'] as Map<String, dynamic>),
      docId: json['docId'] as String?,
    );

Map<String, dynamic> _$$EventDocumentImplToJson(_$EventDocumentImpl instance) =>
    <String, dynamic>{
      'event': instance.event,
      'docId': instance.docId,
    };
