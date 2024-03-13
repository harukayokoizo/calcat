import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:share_calendar/src/features/personal_event/domain/personal_event.dart';

import '../../../common_widgets/application/timestamp_converter.dart';

part 'event_document.freezed.dart';
part 'event_document.g.dart';

@freezed
abstract class EventDocument with _$EventDocument{
  const factory EventDocument({
    PersonalEvent? event,
    String? docId
  }) = _EventDocument;

  factory EventDocument.fromJson(Map<String,dynamic> json) => _$EventDocumentFromJson(json);
}