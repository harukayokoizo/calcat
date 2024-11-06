import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../common_widgets/application/timestamp_converter.dart';

part 'todo.freezed.dart';
part 'todo.g.dart';

@freezed
abstract class Todo with _$Todo{
  const factory Todo({
    String? author,
    String? title,
    bool? pin,
    bool? complete,
    @TimestampConverter() DateTime? updated,
    String? calendarId,
  }) = _Todo;

  factory Todo.fromJson(Map<String,dynamic> json) => _$TodoFromJson(json);
}