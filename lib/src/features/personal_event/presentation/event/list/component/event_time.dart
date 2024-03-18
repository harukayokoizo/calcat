import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

Widget eventTime(bool isAllDay, DateTime from, DateTime to, DateTime focusedDay){
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
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: Center(
        child: Text(
          '終日',
          style: TextStyle(
            //fontWeight: FontWeight.bold,
              fontSize: 18
          ),
        ),
      ),
    );
  }else{
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(displayFrom,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 18,
              //fontWeight: FontWeight.bold,
            ),
          ),
          Text(displayTo,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 18,
              //fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}