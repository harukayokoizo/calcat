// allows to add, remove or reset the appointment collection.
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../domain/event.dart';

class EventDataSource extends CalendarDataSource {
  /// Creates a meeting data source, which used to set the appointment
  /// collection to the calendar
  EventDataSource(List<Event> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return _getMeetingData(index).from!;
  }

  @override
  DateTime getEndTime(int index) {
    return _getMeetingData(index).to!;
  }

  @override
  String getSubject(int index) {
    return _getMeetingData(index).event!;
  }

  // @override
  // Color getColor(int index) {
  //   return _getMeetingData(index).background;
  // }

  @override
  bool isAllDay(int index) {
    return _getMeetingData(index).isAllDay!;
  }

  Event _getMeetingData(int index) {
    final dynamic event = appointments![index];
    late final Event eventData;
    if (event is Event) {
      eventData = event;
    }

    return eventData;
  }
}