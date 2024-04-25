import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../common_widgets/application/timestamp_converter.dart';

part 'notification.freezed.dart';
part 'notification.g.dart';

@freezed
abstract class Notification with _$Notification{
  const factory Notification({
    String? uid,
    @TimestampConverter() DateTime? created,
  }) = _Notification;

  factory Notification.fromJson(Map<String,dynamic> json) => _$NotificationFromJson(json);
}