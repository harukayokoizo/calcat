import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_calendar/src/features/event/application/event_list_provider.dart';
import 'package:share_calendar/src/features/event/presentation/event/registration/repeat_form.dart';
import 'package:share_calendar/src/features/event/presentation/event/registration/title_form.dart';
import 'package:share_calendar/src/features/event/presentation/event/registration/url_form.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../../../common_widgets/application/common_provider.dart';
import '../../../application/event_provider.dart';
import '../../../domain/event.dart';
import '../../../domain/event_document.dart';
import '../../../domain/event_initial_time.dart';
import 'calendar_form.dart';
import 'calendar_time_form.dart';
import 'color_form.dart';
import 'date_form.dart';
import 'location_form.dart';
import 'notification_form.dart';
import 'overview_form.dart';

class EventRegistration extends ConsumerStatefulWidget{
  final DateTime focusedDay;
  final dynamic repositories;
  final String? calendarId;
  const EventRegistration(this.focusedDay, this.repositories, this.calendarId, {super.key});

  @override
  ConsumerState<EventRegistration> createState() => EventRegistrationState();
}

class EventRegistrationState extends ConsumerState<EventRegistration> with TickerProviderStateMixin{
  late TabController tabController = TabController(length: 2, vsync: this);
  late final DateTime focusedDay;
  late final dynamic repositories;
  late final String? calendarId;
  final bool newReg = true;
  final List<DateTime> sameEvents = [];
  final EventInitialTime initialTime = const EventInitialTime({
    'fromHour' : 12,
    'fromMinutes' : 00,
    'toHour' : 12,
    'toMinutes' : 00,
  });

  @override
  void initState() {
    super.initState();
    focusedDay = widget.focusedDay;
    repositories = widget.repositories;
    calendarId = widget.calendarId;
  }

  @override
  Widget build(BuildContext context){
    Widget page;
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

    return Scaffold(
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
          actions: [
            SaveEventButton(null, event, null, repositories, newReg, sameEvents, initialTime),
          ],
          bottom: TabBar(
            controller: tabController,
            onTap: (index) async{
              ref.read(eventFormStateProvider(event).notifier).changeRepeat(index);
            },
            // unselectedLabelColor: Color(0xFFFFFFFF).computeLuminance() < 0.5 ? Colors.white : Colors.black,
            // labelColor: Color(0xFFFFFFFF).computeLuminance() < 0.5 ? Colors.white : Colors.black,
            tabs: const [
              Tab(
                text: '通常',
                iconMargin: EdgeInsets.only(bottom: 0.0),
              ),
              Tab(
                text: 'まとめて作成',
                iconMargin: EdgeInsets.only(bottom: 0.0),
              ),
            ],
          )
      ),
      body: NormalEventRegistration(focusedDay, repositories, calendarId, event, sameEvents, initialTime),
    );

  }
}

class NormalEventRegistration extends ConsumerWidget{
  final Event event;
  final DateTime focusedDay;
  final dynamic repositories;
  final String? calendarId;
  final FocusNode title = FocusNode();
  final FocusNode overview = FocusNode();
  final FocusNode url = FocusNode();
  final FocusNode location = FocusNode();
  final List<DateTime> sameEvents;
  final EventInitialTime initialTime;
  NormalEventRegistration(this.focusedDay, this.repositories, this.calendarId, this.event, this.sameEvents, this.initialTime, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref){
    final double bottomPadding = MediaQuery.of(context).padding.bottom;
    final Event eventState = ref.watch(eventFormStateProvider(event));

    return LayoutBuilder(
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
              Expanded(
                child: SingleChildScrollView(
                  child: Column(children: [
                    TitleForm(event, title),
                    OverViewForm(event, overview),
                    if(eventState.repeat == 0)
                      DateSettingFormat(event),
                    UrlForm(event, url),
                    LocationForm(event, location),
                    ColorForm(event),
                    // const Expanded(child: SizedBox(),),
                  ],),
                ),
              ),
              if(eventState.repeat == 1)
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
                  child: EventCalendarForm(event, repositories, sameEvents, initialTime),
                ),
              Container(height: bottomPadding ,color: Colors.white,)
            ],
          ),
        );
      }
    );
  }
}

class SaveEventButton extends ConsumerWidget{
  final EventDocument? eventDoc;
  final Event event;
  final int? value;
  final dynamic repositories;
  final bool newReg;
  final List<DateTime> sameEvents;
  final EventInitialTime initialTime;
  const SaveEventButton(this.eventDoc, this.event, this.value, this.repositories, this.newReg, this.sameEvents, this.initialTime, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final personalEvent = ref.watch(eventFormStateProvider(event));
    return Padding(
      padding: const EdgeInsets.only(right: 20.0),
      child: GestureDetector(
        onTap: personalEvent.title == null || personalEvent.title!.isEmpty ? null : (){
          try{
            if(newReg){
              ref.read(eventFormStateProvider(event).notifier).createEvent(repositories, newReg, sameEvents, initialTime);
            }else{
              ref.read(eventFormStateProvider(event).notifier).updateEvent(value!, eventDoc!, repositories, newReg, sameEvents, initialTime);
            }
            Navigator.of(context).pop(true);
          }catch (e){
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Colors.red,
                content: Text(
                  e.toString(),
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            );
          }
        },
        child: Text(
          "保存",
          style: TextStyle(
              fontSize: 20,
              color: personalEvent.title == null || personalEvent.title!.isEmpty ? Colors.grey : Colors.blue,
              fontWeight: FontWeight.w700
          ),
        ),
      ),
    );
  }
}