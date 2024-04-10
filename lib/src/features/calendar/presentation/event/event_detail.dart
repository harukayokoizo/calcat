import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_calendar/src/features/event/presentation/event/detail/title_detail.dart';

import '../../../event/domain/event.dart';
import '../../../event/domain/event_document.dart';
import '../../../event/presentation/event/detail/color_detail.dart';
import '../../../event/presentation/event/detail/date_detail.dart';
import '../../../event/presentation/event/detail/notification_detail.dart';
import '../../../event/presentation/event/detail/overview_detail.dart';
import '../../../event/presentation/event/detail/repeat_detail.dart';
import '../../../event/presentation/event/edit/delete_action_button.dart';
import '../../../event/presentation/event/edit/edit_action_button.dart';
import '../../../notification/data/public_event_notification_repositories.dart';
import '../../../notification/presentation/notification_settings_button.dart';


class PublicEventDetail extends ConsumerWidget{
  EventDocument eventDoc;
  dynamic repositories;
  bool followCalendar;
  PublicEventDetail(this.eventDoc, this.repositories, this.followCalendar, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
            EventColorDetail(event),
            // EventNotificationDetail(event),
            EventRepeatDetail(event),
            const SizedBox(height: 100,)
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          NotificationButton(eventDoc, true),
          if(!followCalendar)
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: DeleteActionButton(eventDoc, repositories),
            ),
          if(!followCalendar)
            Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: EditActionButton(eventDoc, repositories)
            ),
        ],
      ),
    );
  }
}