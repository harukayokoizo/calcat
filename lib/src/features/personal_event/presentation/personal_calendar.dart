import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../application/calendar.dart';
import '../application/personal_event_provider.dart';

class PersonalCalendarPage extends ConsumerStatefulWidget{
  const PersonalCalendarPage({super.key});

  @override
  ConsumerState createState() => PersonalCalendarPageState();

}

class PersonalCalendarPageState extends ConsumerState{
  // void _onLongPress(CalendarLongPressDetails details){
  //   print('a');
  // }
  @override
  Widget build(BuildContext context){
    //final events = ref.watch(personalEventList);
    //print(events);
    return SfCalendar(
      view:CalendarView.month,
      monthViewSettings: const MonthViewSettings(
        showAgenda: true,
        showTrailingAndLeadingDates: false
      ),
      // dataSource: events.when(
      //   error: (err, _) => EventDataSource([]), //エラー時
      //   loading: () => EventDataSource([]), //読み込み時
      //   data: (data) => EventDataSource(data), //データ受け取り時
      // ),
      //onLongPress: _onLongPress,

    );
  }
}