import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../common_widgets/application/timestamp_converter.dart';

part 'personal_event.freezed.dart';
part 'personal_event.g.dart';

@freezed
abstract class PersonalEvent with _$PersonalEvent{
  const factory PersonalEvent({
    String? uid,
    String? title,
    String? event,
    String? image,
    int? color,
    bool? isAllDay,
    @TimestampConverter() DateTime? from,
    @TimestampConverter() DateTime? to,
    List<int>? notification,
    int? repeat,
    @TimestampConverter() DateTime? endDate,
    String? sameEventId,
    int? number,
  }) = _PersonalEvent;

  factory PersonalEvent.fromJson(Map<String,dynamic> json) => _$PersonalEventFromJson(json);
}