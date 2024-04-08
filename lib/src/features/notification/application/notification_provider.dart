import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_calendar/src/features/notification/data/personal_event_notification_repositories.dart';

final eventNotification = StreamProvider.family<bool, dynamic>(
        (ref, notificationRepo) {
          var exists = notificationRepo.getNotification();
          return exists;
        });