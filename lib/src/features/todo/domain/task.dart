import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../common_widgets/application/timestamp_converter.dart';

part 'task.freezed.dart';
part 'task.g.dart';

@freezed
abstract class Task with _$Task{
  const factory Task({
    String? task,
    String? user,
    bool? check,
    @TimestampConverter() DateTime? created,
    @TimestampConverter() DateTime? updated,
    String? todoId,
  }) = _Task;

  factory Task.fromJson(Map<String,dynamic> json) => _$TaskFromJson(json);
}