import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_calendar/src/features/personal_event/presentation/event_detail/overview_detail.dart';
import 'package:share_calendar/src/features/personal_event/presentation/event_detail/title_detail.dart';

import '../../application/event_provider.dart';
import '../../domain/event_document.dart';
import '../../domain/event.dart';
import '../event_edit/delete_action_button.dart';
import '../event_edit/delete_dialog.dart';
import '../event_edit/edit_action_button.dart';
import '../event_edit/event_edit_page.dart';
import '../event_registration/date_form.dart';
import 'action_sheet.dart';
import 'color_detail.dart';
import 'date_detail.dart';
import 'notification_detail.dart';
import 'repeat_detail.dart';
import 'modal_bottom_sheet.dart';

class EventDetail extends ConsumerWidget{
  EventDocument eventDoc;
  dynamic repositories;
  EventDetail(this.eventDoc, this.repositories, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Event event = eventDoc.event!;
    final double deviceWidth = MediaQuery.of(context).size.width;
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
            if(event.event != null)
              OverViewDetail(event),
            EventDateDetail(event),
            EventColorDetail(event),
            EventNotificationDetail(event),
            EventRepeatDetail(event),
            const SizedBox(height: 100,)
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          DeleteActionButton(eventDoc, repositories),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: EditActionButton(eventDoc, repositories)
          ),
        ],
      ),
    );
  }
}