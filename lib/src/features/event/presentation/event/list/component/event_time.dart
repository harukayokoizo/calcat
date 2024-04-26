import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

Widget eventTime(bool isAllDay, DateTime from, DateTime to, DateTime focusedDay, int color){
  DateTime fromDate = DateTime(from.year, from.month, from.day);
  DateTime toDate = DateTime(to.year, to.month, to.day);
  DateTime focusedDate = DateTime(focusedDay.year, focusedDay.month, focusedDay.day);
  DateFormat displayFormat = DateFormat("HH:mm");
  String displayFrom = displayFormat.format(from);
  String displayTo = displayFormat.format(to);
  if(!fromDate.isAtSameMomentAs(toDate)){
    if(focusedDate.isAtSameMomentAs(fromDate)){
      displayTo = '00:00';
    }else if(focusedDate.isAtSameMomentAs(toDate)){
      displayFrom = '00:00';
    }else{
      displayFrom = '00:00';
      displayTo = '00:00';
    }
  }

  if(isAllDay){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: 60,
        child: Center(
          child: Text(
            '終日',
            style: TextStyle(
              color: Color(color).computeLuminance() < 0.5 ? Colors.white : Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }else{
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: 60,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(displayFrom,
              style: TextStyle(
                color: Color(color).computeLuminance() < 0.5 ? Colors.white : Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(displayTo,
              style: TextStyle(
                color: Color(color).computeLuminance() < 0.5 ? Colors.white : Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}