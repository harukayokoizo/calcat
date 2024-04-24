import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_calendar/src/features/event/presentation/event/detail/location_detail.dart';
import 'package:share_calendar/src/features/event/presentation/event/detail/title_detail.dart';
import 'package:share_calendar/src/features/event/presentation/event/detail/url_detail.dart';


import '../../../../notification/data/personal_event_notification_repositories.dart';
import '../../../domain/event_document.dart';
import '../../../domain/event.dart';
import 'date_detail.dart';
import 'floationg_action_button.dart';
import 'overview_detail.dart';

class EventDetail extends ConsumerWidget{
  EventDocument eventDoc;
  dynamic repositories;
  EventDetail(this.eventDoc, this.repositories, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool public = false;
    Event event = eventDoc.event!;
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
      floatingActionButton: EventFloatingButton(eventDoc, repositories, public),
    );
  }
}