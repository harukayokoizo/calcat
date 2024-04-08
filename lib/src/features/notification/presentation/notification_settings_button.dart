import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../event/domain/event_document.dart';
import '../application/notification_provider.dart';
import '../data/personal_event_notification_repositories.dart';

class NotificationButton extends ConsumerWidget{
  EventDocument eventDoc;
  dynamic notificationRepo;

  NotificationButton(this.eventDoc, this.notificationRepo, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref){
    var notification = ref.watch(eventNotification(notificationRepo));
    return notification.when(
        data: (value){
          if(value){
            return FloatingActionButton(
                heroTag: "notification_delete",
                child: const Icon(Icons.notifications),
                onPressed: () async {
                  //delete
                  notificationRepo.deleteNotification();
                }
            );
          }else{
            return FloatingActionButton(
                heroTag: "notification_create",
                child: const Icon(Icons.notifications_off),
                onPressed: () async {
                  // create
                  notificationRepo.createNotification();
                }
            );
          }
        },
        error:(error, st) => const SizedBox(),
        loading: () => const SizedBox()
    );

  }

}