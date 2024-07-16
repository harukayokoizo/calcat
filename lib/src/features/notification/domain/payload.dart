import 'package:freezed_annotation/freezed_annotation.dart';

part 'payload.freezed.dart';
part 'payload.g.dart';

@freezed
abstract class Payload with _$Payload{
  const factory Payload({
    String? calendarId,
    String? eventId,
  }) = _Payload;

  factory Payload.fromJson(Map<String,dynamic> json) => _$PayloadFromJson(json);
}