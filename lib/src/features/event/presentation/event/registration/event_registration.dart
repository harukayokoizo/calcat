import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_calendar/src/features/event/application/event_list_provider.dart';
import 'package:share_calendar/src/features/event/presentation/event/registration/repeat_form.dart';
import 'package:share_calendar/src/features/event/presentation/event/registration/title_form.dart';
import 'package:share_calendar/src/features/event/presentation/event/registration/url_form.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../../../common_widgets/application/common_provider.dart';
import '../../../application/event_provider.dart';
import '../../../domain/event.dart';
import 'color_form.dart';
import 'date_form.dart';
import 'location_form.dart';
import 'notification_form.dart';
import 'overview_form.dart';

class EventRegistration extends ConsumerWidget{
  final DateTime focusedDay;
  final dynamic repositories;
  final String? calendarId;
  final FocusNode title = FocusNode();
  final FocusNode overview = FocusNode();
  final FocusNode url = FocusNode();
  final FocusNode location = FocusNode();
  EventRegistration(this.focusedDay, this.repositories, this.calendarId, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref){
    final user = ref.read(currentUserProvider);
    Event event = Event(
        uid: user!.uid,
        title: null,
        overview: null,
        image: null,
        color: 7,
        url: null,
        location: null,
        isAllDay: true,
        from: focusedDay,
        to: focusedDay,
        repeat: 0,
        endDate: null,
        sameEventId: null,
        number: null,
        calendarId: calendarId,
        notificationExist: false,
        calendarMonth: null,
    );
    ref.watch(eventFormStateProvider(event));
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 5,
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon: const Icon(Icons.close),
        ),
        titleTextStyle: const TextStyle(
          color: Colors.black,
          fontSize: 20,
          //fontWeight: FontWeight.bold,
        ),
        title: const Text('予定作成'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: (){
            FocusScope.of(context).unfocus();
            title.unfocus();
            overview.unfocus();
            url.unfocus();
            location.unfocus();
          },
          onHorizontalDragCancel: (){
            FocusScope.of(context).unfocus();
            title.unfocus();
            overview.unfocus();
            url.unfocus();
            location.unfocus();
          },
          onHorizontalDragDown: (value){
            FocusScope.of(context).unfocus();
            title.unfocus();
            overview.unfocus();
            url.unfocus();
            location.unfocus();
          },
          child: Column(
            children: [
              TitleForm(event, title),
              OverViewForm(event, overview),
              DateSettingFormat(event),
              UrlForm(event, url),
              LocationForm(event, location),
              ColorForm(event),
              //NotificationForm(event),
              RepeatForm(event),
              const Expanded(child: SizedBox(),),
            //   Container(
            //     height: 200,
            //     child: TableCalendar(
            //       firstDay: DateTime.utc(2024,01,01),
            //       lastDay: DateTime.utc(2050,12,31),
            //       focusedDay: focusedDay,
            //       headerVisible: false,
            //       rowHeight: 50,
            //       //shouldFillViewport: true,
            //       //availableGestures: AvailableGestures.verticalSwipe,
            //       locale: 'ja_JP',
            //       calendarFormat: CalendarFormat.month,
            //
            //     ),
            // ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10.0, right: 10.0),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: SaveEventButton(event, repositories),
                ),
              )
            ],
          ),
        ),
      )
    );
  }
}

class SaveEventButton extends ConsumerWidget{
  Event event;
  dynamic repositories;
  SaveEventButton(this.event, this.repositories, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref){
    final personalEvent = ref.watch(eventFormStateProvider(event));

    return ElevatedButton(
      onPressed: personalEvent.title == null || personalEvent.title!.isEmpty ? null : (){
        ref.read(eventFormStateProvider(event).notifier).createEvent(repositories);
        Navigator.of(context).pop();
      },
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
        //side: BorderSide(color: Colors.black)
      ),
      child: const Text(
        "保存",
        style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold
        ),
      ),
    );
  }
}