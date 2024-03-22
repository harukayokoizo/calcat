import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../common_widgets/application/timestamp_converter.dart';

part '../../calendar/domain/calendar_user.freezed.dart';
part '../../calendar/domain/calendar_user.g.dart';

@freezed
abstract class CalendarUser with _$CalendarUser{
  const factory CalendarUser({
    String? uid,
    @DocumentReferenceConverter() DocumentReference? calendar,
    @TimestampConverter() DateTime? create,
  }) = _CalendarUser;

  factory CalendarUser.fromJson(Map<String,dynamic> json) => _$CalendarUserFromJson(json);
}