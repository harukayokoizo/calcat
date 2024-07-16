import 'package:equatable/equatable.dart';

class CalendarEvent extends Equatable{
  String calendarId;
  String calendarMonth;

  CalendarEvent(this.calendarId, this.calendarMonth);

  @override
  List<Object> get props => [calendarId, calendarMonth];
}