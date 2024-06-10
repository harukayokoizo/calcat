import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_calendar/src/features/event/presentation/event/detail/title_detail.dart';

import '../../../event/domain/event.dart';
import '../../../event/domain/event_document.dart';
import '../../../event/presentation/event/detail/color_detail.dart';
import '../../../event/presentation/event/detail/date_detail.dart';
import '../../../event/presentation/event/detail/floationg_action_button.dart';
import '../../../event/presentation/event/detail/location_detail.dart';
import '../../../event/presentation/event/detail/notification_detail.dart';
import '../../../event/presentation/event/detail/overview_detail.dart';
import '../../../event/presentation/event/detail/repeat_detail.dart';
import '../../../event/presentation/event/detail/url_detail.dart';
import '../../../event/presentation/event/edit/delete_action_button.dart';
import '../../../event/presentation/event/edit/edit_action_button.dart';
import '../../../notification/data/public_event_notification_repositories.dart';
import '../../../notification/presentation/notification_settings_button.dart';

class PublicEventDetail extends ConsumerStatefulWidget {
  final EventDocument eventDoc;
  final dynamic repositories;
  final bool followCalendar;

  const PublicEventDetail(this.eventDoc, this.repositories, this.followCalendar,
      {super.key});

  @override
  ConsumerState<PublicEventDetail> createState() => PublicEventDetailState();
}

class PublicEventDetailState extends ConsumerState<PublicEventDetail>{
  late EventDocument eventDoc;
  late dynamic repositories;
  late bool followCalendar;

  @override
  void initState() {
    super.initState();
    eventDoc = widget.eventDoc;
    repositories = widget.repositories;
    followCalendar = widget.followCalendar;
  }

  void reload(){
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    bool public = true;
    Event event = eventDoc.event!;
    Future<bool> getNotification = ref.read(publicEventNotificationRepositories(eventDoc)).getNotification();
    return Scaffold(
      appBar: AppBar(
        elevation: 5,
        titleTextStyle: const TextStyle(
          color: Colors.black,
          fontSize: 20,
          //fontWeight: FontWeight.bold,
        ),
        title: const Text('詳細'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            TitleDetail(event),
            if(event.overview != null)
              OverViewDetail(event),
            EventDateDetail(event),
            if(event.url != null)
              UrlDetail(event),
            if(event.location != null)
              LocationDetail(event),
            // EventColorDetail(event),
            // // EventNotificationDetail(event),
            // EventRepeatDetail(event),
            const SizedBox(height: 100,)
          ],
        ),
      ),
      floatingActionButton: followCalendar
          ? NotificationButton(eventDoc, true)
          : FutureBuilder(
              future: getNotification,
              builder: (BuildContext context, AsyncSnapshot<bool> notification) {
                if(notification.connectionState == ConnectionState.done){
                  return EventFloatingButton(eventDoc, repositories, public, notification.data!);
                }else{
                  return const SizedBox();
                }
              }),
    );
  }
}