import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_calendar/src/features/event/presentation/event/detail/location_detail.dart';
import 'package:share_calendar/src/features/event/presentation/event/detail/title_detail.dart';
import 'package:share_calendar/src/features/event/presentation/event/detail/url_detail.dart';


import '../../../../notification/data/personal_event_notification_repositories.dart';
import '../../../../notification/data/public_event_notification_repositories.dart';
import '../../../data/personal_event_repositories.dart';
import '../../../domain/event_document.dart';
import '../../../domain/event.dart';
import 'date_detail.dart';
import 'floationg_action_button.dart';
import 'overview_detail.dart';

class EventDetail extends ConsumerStatefulWidget {
  final EventDocument eventDoc;
  final dynamic repositories;

  const EventDetail(this.eventDoc, this.repositories, {super.key});

  @override
  ConsumerState<EventDetail> createState() => EventDetailState();
}

class EventDetailState extends ConsumerState<EventDetail>{
  late EventDocument eventDoc;
  late dynamic repositories;

  @override
  void initState() {
    super.initState();
    eventDoc = widget.eventDoc;
    repositories = widget.repositories;
  }

  void reload(){
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    bool public = false;
    Event event = eventDoc.event!;
    Future<bool> getNotification = ref.read(eventRepositories).getSingleEvent(eventDoc.docId!);
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
            // EventNotificationDetail(event),
            // EventRepeatDetail(event),
            const SizedBox(height: 100,)
          ],
        ),
      ),
      floatingActionButton: FutureBuilder(
          future: getNotification,
          builder: (BuildContext context, AsyncSnapshot<bool> notification) {
            if(notification.connectionState == ConnectionState.done){
              if(notification.connectionState == ConnectionState.done){
                return EventFloatingButton(eventDoc, repositories, public, notification.data!);
              }else{
                return const SizedBox();
              }
            }else{
              return const SizedBox();
            }
          }
      ),
    );
  }
}