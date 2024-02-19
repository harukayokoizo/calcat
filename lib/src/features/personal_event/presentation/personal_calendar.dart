import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class PersonalCalendarPage extends StatefulWidget{
  const PersonalCalendarPage({super.key});

  @override
  State<PersonalCalendarPage> createState() => PersonalCalendarPageState();

}

class PersonalCalendarPageState extends State<PersonalCalendarPage>{
  // void _onLongPress(CalendarLongPressDetails details){
  //   print('a');
  // }
  @override
  Widget build(BuildContext context){
    return SfCalendar(
      view:CalendarView.month,
      monthViewSettings: const MonthViewSettings(
        showAgenda: true,
        showTrailingAndLeadingDates: false
      ),
      //dataSource: ,
      //onLongPress: _onLongPress,

    );
  }
}