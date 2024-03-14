import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:share_calendar/src/features/personal_event/domain/event.dart';

import '../../../common_widgets/application/timestamp_converter.dart';
import 'calendar.dart';

part 'calendar_document.freezed.dart';
part 'calendar_document.g.dart';

@freezed
abstract class CalendarDocument with _$CalendarDocument{
  const factory CalendarDocument({
    Calendar? calendar,
    String? docId
  }) = _CalendarDocument;

  factory CalendarDocument.fromJson(Map<String,dynamic> json) => _$CalendarDocumentFromJson(json);
}