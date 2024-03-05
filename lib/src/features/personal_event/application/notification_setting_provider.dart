import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_calendar/src/features/personal_event/application/personal_event_provider.dart';

final notificationList = StateProvider<List<dynamic>>(
        (ref) => [
      '0分前',
      '10分前',
      '15分前',
      '30分前',
      '1時間前',
      '2時間前',
      '3時間前',
      '1日前',
      '2日前',
      '7日前'
    ]
);

final notificationCheckList = StateProvider.autoDispose<List<int>>(
    (ref){
          final personalEvent = ref.read(personalEventFormStateProvider);
          return personalEvent.notification!;
    }
);