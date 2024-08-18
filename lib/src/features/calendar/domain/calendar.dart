import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../common_widgets/application/timestamp_converter.dart';

part 'calendar.freezed.dart';
part 'calendar.g.dart';

@freezed
abstract class Calendar with _$Calendar{
  const factory Calendar({
    String? author,
    String? title,
    String? description,
    String? image,
    String? fileName,
    int? publicPreference,
    String? password,
    @TimestampConverter() DateTime? created,
    @TimestampConverter() DateTime? updated,
    List<String>? searchIndex,
    List<String>? calendarOwner,
    List<Map<String, String>>?  calendarLink,
    int? followCount,
  }) = _Calendar;

  factory Calendar.fromJson(Map<String,dynamic> json) => _$CalendarFromJson(json);
}