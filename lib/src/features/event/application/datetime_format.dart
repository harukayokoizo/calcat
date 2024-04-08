
import 'package:flutter_riverpod/flutter_riverpod.dart';

final dateTimeFormatClass = Provider.autoDispose.family<DateTimeFormat, DateTime>(
        (ref, date) => DateTimeFormat(date)
);

class DateTimeFormat{
  DateTime date;
  final int year;
  final int month;
  final int day;
  final int weekdayNum;
  final int hour;
  final int minute;
  final Map<int, String> weekday = {
    1:'月',
    2:'火',
    3:'水',
    4:'木',
    5:'金',
    6:'土',
    7:'日',
  };

  DateTimeFormat(this.date) :
        year = date.year,
        month = date.month,
        day = date.day,
        weekdayNum = date.weekday,
        hour = date.hour,
        minute = date.minute;


  String dateJaFormat(){
    final year = this.year;
    final month = this.month;
    final day = this.day;
    final weekdayNum = this.weekdayNum;

    return '$year年$month月$day日(${weekday[weekdayNum]})';
  }
}