import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../application/event_provider.dart';
import '../../../domain/event_document.dart';
import '../../../domain/event.dart';
import '../../../domain/event_initial_time.dart';
import '../registration/calendar_form.dart';
import '../registration/color_form.dart';
import '../registration/date_form.dart';
import '../registration/event_registration.dart';
import '../registration/location_form.dart';
import '../registration/overview_form.dart';
import '../registration/title_form.dart';
import '../registration/url_form.dart';


class EventEdit extends ConsumerWidget{
  final EventDocument eventDoc;
  final int value;
  final dynamic repositories;
  final FocusNode title = FocusNode();
  final FocusNode overview = FocusNode();
  final FocusNode url = FocusNode();
  final FocusNode location = FocusNode();
  final newReg = false;
  final List<DateTime> sameEvents;
  EventEdit(this.eventDoc, this.value, this.repositories, this.sameEvents, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref){
    final double bottomPadding = MediaQuery.of(context).padding.bottom;
    final double deviceHeight = MediaQuery.of(context).size.height;
    Event event = eventDoc.event!;
    Map<String, int> time;
    if(event.isAllDay!){
      time = {
        'fromHour' : 12,
        'fromMinutes' : 00,
        'toHour' : 12,
        'toMinutes' : 00,
      };
    }else{
      time = {
        'fromHour' : event.from!.hour,
        'fromMinutes' : event.from!.minute,
        'toHour' : event.to!.hour,
        'toMinutes' : event.to!.minute,
      };
    }
    final EventInitialTime initialTime = EventInitialTime(time);

    if(value == 1){
      event = event.copyWith(repeat: 0, endDate: null);
      ref.watch(eventFormStateProvider(event));
    }else{
      ref.watch(eventFormStateProvider(event));
    }

    return SizedBox(
      height: deviceHeight,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop(false);
            },
            icon: const Icon(Icons.close),
          ),
          elevation: 5,
          titleTextStyle: const TextStyle(
            color: Colors.black,
            fontSize: 18,
            //fontWeight: FontWeight.bold,
          ),
          title: const Text('予定編集'),
          centerTitle: true,
          actions: [
            SaveEventButton(eventDoc, event, value, repositories, newReg, sameEvents, initialTime),
          ],
        ),
        body: LayoutBuilder(
          builder: (context, constraint) {
            return GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: (){
                FocusScope.of(context).unfocus();
                title.unfocus();
                overview.unfocus();
                url.unfocus();
                location.unfocus();
              },
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          TitleForm(event, title),
                          OverViewForm(event, overview),
                          if(event.repeat == 0)
                            DateSettingFormat(event),
                          UrlForm(event, url),
                          LocationForm(event, location),
                          ColorForm(event),
                        ],
                      ),
                    ),
                  ),
                  if(event.repeat == 1)
                    Container(
                      height: constraint.maxHeight * 0.5,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5), // 影の色
                            spreadRadius: 2, // スプレッド半径
                            blurRadius: 5, // ぼかし半径
                            offset: const Offset(0, 3), // オフセット（x, y）
                          ),
                        ],
                      ),
                      child: EventCalendarForm(event, repositories, sameEvents, initialTime, event.from!),
                    ),
                  Container(height: bottomPadding ,color: Colors.white,)
                ],
              ),
            );
          }
        ),
      ),
    );
  }
}