// Copyright 2019 Aleksander Woźniak
// SPDX-License-Identifier: Apache-2.0

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

import '../customization/calendar_builders.dart';
import '../customization/calendar_style.dart';

class CellContent extends StatelessWidget {
  final DateTime day;
  final DateTime focusedDay;
  final dynamic locale;
  final bool isTodayHighlighted;
  final bool isToday;
  final bool isSelected;
  final bool isRangeStart;
  final bool isRangeEnd;
  final bool isWithinRange;
  final bool isOutside;
  final bool isDisabled;
  final bool isHoliday;
  final bool isWeekend;
  final bool isSaturday;
  final bool isSunday;
  final CalendarStyle calendarStyle;
  final CalendarBuilders calendarBuilders;

  const CellContent({
    Key? key,
    required this.day,
    required this.focusedDay,
    required this.calendarStyle,
    required this.calendarBuilders,
    required this.isTodayHighlighted,
    required this.isToday,
    required this.isSelected,
    required this.isRangeStart,
    required this.isRangeEnd,
    required this.isWithinRange,
    required this.isOutside,
    required this.isDisabled,
    required this.isHoliday,
    required this.isWeekend,
    required this.isSaturday,
    required this.isSunday,
    this.locale,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dowLabel = DateFormat.EEEE(locale).format(day);
    final dayLabel = DateFormat.yMMMMd(locale).format(day);
    final semanticsLabel = '$dowLabel, $dayLabel';
    Widget? date;

    // Widget? cell =
    //     calendarBuilders.prioritizedBuilder?.call(context, day, focusedDay);
    //
    // if (cell != null) {
    //   return Semantics(
    //     label: semanticsLabel,
    //     excludeSemantics: true,
    //     child: cell,
    //   );
    // }

    final now = DateTime.now();
    final today = (now.year == day.year && now.month == day.month && now.day == day.day) ? true : false;
    final text = '${day.day}';
    var margin = calendarStyle.cellMargin;
    final padding = calendarStyle.cellPadding;
    final alignment = calendarStyle.cellAlignment;
    //final duration = const Duration(milliseconds: 250);

    if (isOutside) {
      //その月にない日にち
      date = calendarBuilders.outsideBuilder?.call(context, day, focusedDay) ??
          Container(
            margin: margin,
            padding: padding,
            decoration: calendarStyle.outsideDecoration,
            alignment: alignment,
            child: Align(alignment: Alignment.topLeft, child: Text(text, style: calendarStyle.outsideTextStyle)),
          );
    } else {
      var style = calendarStyle.defaultTextStyle;
      if(isSaturday) style = calendarStyle.isSaturdayTextStyle;
      if(isSunday) style = calendarStyle.isSundayTextStyle;
      if(today) style = const TextStyle(color: Colors.white, fontWeight: FontWeight.bold);
      final color = today ? Colors.black : Colors.white;
      //日にち
      date = LayoutBuilder(
        builder: (context, constraints) {
          return calendarBuilders.defaultBuilder?.call(context, day, focusedDay) ??
              Container(
                // margin: margin,
                // padding: padding,
                decoration: isWeekend
                    ? calendarStyle.weekendDecoration
                    : calendarStyle.defaultDecoration,
                alignment: alignment,
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    margin: const EdgeInsets.only(top: 1.0, left: 1.0),
                    //width: constraints.maxWidth / 2.5,
                    color: color,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 2.0, right: 2.0),
                      child: Text(
                        text,
                        style: style
                      ),
                    ),
                  ),
                ),
              );
        }
      );
    }

    return Semantics(
      label: semanticsLabel,
      excludeSemantics: true,
      child: date,
    );
  }
}


class CellContentOriginal extends StatelessWidget {
  final DateTime day;
  final DateTime focusedDay;
  final dynamic locale;
  final bool isTodayHighlighted;
  final bool isToday;
  final bool isSelected;
  final bool isRangeStart;
  final bool isRangeEnd;
  final bool isWithinRange;
  final bool isOutside;
  final bool isDisabled;
  final bool isHoliday;
  final bool isWeekend;
  final bool isSaturday;
  final bool isSunday;
  final CalendarStyle calendarStyle;
  final CalendarBuilders calendarBuilders;

  const CellContentOriginal({
    Key? key,
    required this.day,
    required this.focusedDay,
    required this.calendarStyle,
    required this.calendarBuilders,
    required this.isTodayHighlighted,
    required this.isToday,
    required this.isSelected,
    required this.isRangeStart,
    required this.isRangeEnd,
    required this.isWithinRange,
    required this.isOutside,
    required this.isDisabled,
    required this.isHoliday,
    required this.isWeekend,
    required this.isSaturday,
    required this.isSunday,
    this.locale,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dowLabel = DateFormat.EEEE(locale).format(day);
    final dayLabel = DateFormat.yMMMMd(locale).format(day);
    final semanticsLabel = '$dowLabel, $dayLabel';
    Widget? date;

    Widget? cell =
        calendarBuilders.prioritizedBuilder?.call(context, day, focusedDay);

    if (cell != null) {
      return Semantics(
        label: semanticsLabel,
        excludeSemantics: true,
        child: cell,
      );
    }

    final now = DateTime.now();
    final today = (now.year == day.year && now.month == day.month && now.day == day.day) ? true : false;
    final text = '${day.day}';
    var margin = calendarStyle.cellMarginOriginal;
    final padding = calendarStyle.cellPadding;
    final alignment = calendarStyle.cellAlignment;
    final duration = const Duration(milliseconds: 250);

    if (isDisabled) {
      //firstDay,endDayの範囲外の日にち
      cell = calendarBuilders.disabledBuilder?.call(context, day, focusedDay) ??
          AnimatedContainer(
            duration: duration,
            margin: margin,
            padding: padding,
            decoration: calendarStyle.disabledDecoration,
            alignment: alignment,
            child: Text(text, style: calendarStyle.disabledTextStyle),
          );
    } else if (isSelected) {
      //選択された日にち
      cell = calendarBuilders.selectedBuilder?.call(context, day, focusedDay) ??
          AnimatedContainer(
            duration: duration,
            margin: margin,
            padding: padding,
            decoration: calendarStyle.selectedDecoration,
            alignment: alignment,
            child: Text(text, style: calendarStyle.selectedTextStyle),
          );
    } else if (isRangeStart) {
      cell =
          calendarBuilders.rangeStartBuilder?.call(context, day, focusedDay) ??
              AnimatedContainer(
                duration: duration,
                margin: margin,
                padding: padding,
                decoration: calendarStyle.rangeStartDecoration,
                alignment: alignment,
                child: Text(text, style: calendarStyle.rangeStartTextStyle),
              );
    } else if (isRangeEnd) {
      cell = calendarBuilders.rangeEndBuilder?.call(context, day, focusedDay) ??
          AnimatedContainer(
            duration: duration,
            margin: margin,
            padding: padding,
            decoration: calendarStyle.rangeEndDecoration,
            alignment: alignment,
            child: Text(text, style: calendarStyle.rangeEndTextStyle),
          );
    } else if (isToday && isTodayHighlighted) {
      //今日の日にち
      cell = calendarBuilders.todayBuilder?.call(context, day, focusedDay) ??
          AnimatedContainer(
            duration: duration,
            margin: margin,
            padding: padding,
            decoration: calendarStyle.todayDecoration,
            alignment: alignment,
            child: Text(text, style: calendarStyle.todayTextStyle),
          );
    } else if (isHoliday) {
      cell = calendarBuilders.holidayBuilder?.call(context, day, focusedDay) ??
          AnimatedContainer(
            duration: duration,
            margin: margin,
            padding: padding,
            decoration: calendarStyle.holidayDecoration,
            alignment: alignment,
            child: Text(text, style: calendarStyle.holidayTextStyle),
          );
    } else if (isWithinRange) {
      cell =
          calendarBuilders.withinRangeBuilder?.call(context, day, focusedDay) ??
              AnimatedContainer(
                duration: duration,
                margin: margin,
                padding: padding,
                decoration: calendarStyle.withinRangeDecoration,
                alignment: alignment,
                child: Text(text, style: calendarStyle.withinRangeTextStyle),
              );
    } else if (isOutside) {
      //その月にない日にち
      cell = calendarBuilders.outsideBuilder?.call(context, day, focusedDay) ??
          AnimatedContainer(
            duration: duration,
            margin: margin,
            padding: padding,
            decoration: calendarStyle.outsideDecoration,
            alignment: alignment,
            child: Text(text, style: calendarStyle.outsideTextStyle),
          );
    } else {
      //日にち
      cell = calendarBuilders.defaultBuilder?.call(context, day, focusedDay) ??
          AnimatedContainer(
            duration: duration,
            margin: margin,
            padding: padding,
            decoration: isWeekend
                ? calendarStyle.weekendDecoration
                : calendarStyle.defaultDecoration,
            alignment: alignment,
            child: Text(
              text,
              style: isWeekend
                  ? calendarStyle.weekendTextStyle
                  : calendarStyle.defaultTextStyle,
            ),
          );
    }

    return Semantics(
      label: semanticsLabel,
      excludeSemantics: true,
      child: cell,
    );
  }
}