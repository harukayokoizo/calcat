import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../common_widgets/application/timestamp_converter.dart';

part 'event.freezed.dart';
part 'event.g.dart';

@freezed
abstract class Event with _$Event{
  const factory Event({
    String? uid,
    String? title,
    String? overview,
    String? image,
    int? color,
    String? url,
    String? location,
    bool? isAllDay,
    @TimestampConverter() DateTime? from,
    @TimestampConverter() DateTime? to,
    int? repeat,
    @TimestampConverter() DateTime? endDate,
    String? sameEventId,
    int? number,
    String? calendarId,
    bool? notificationExist,
    String? calendarMonth,
  }) = _Event;

  factory Event.fromJson(Map<String,dynamic> json) => _$EventFromJson(json);
}