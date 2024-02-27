
import 'package:flutter_riverpod/flutter_riverpod.dart';

final dateTimeFormatClass = Provider.autoDispose.family<DateTimeFormat, DateTime>(
        (ref, date) => DateTimeFormat(date)
);

class DateTimeFormat{
  DateTime date;
  Map<int, String> weekday = {
    1:'月',
    2:'火',
    3:'水',
    4:'木',
    5:'金',
    6:'土',
    7:'日',
  };

  DateTimeFormat(this.date);

  String dateJaFormat(){
    final year = date.year;
    final month = date.month;
    final day = date.day;
    final weekdayNum = date.weekday;

    return '$year年$month月$day日(${weekday[weekdayNum]})';
  }
}