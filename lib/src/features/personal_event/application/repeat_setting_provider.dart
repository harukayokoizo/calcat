import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_calendar/src/features/personal_event/application/personal_event_provider.dart';

import '../domain/personal_event.dart';

final repeatList = StateProvider<List<dynamic>>(
        (ref) => [
          'なし',
          '毎日',
          '毎週',
          //'毎月'
        ]
);

final repeatEndDate = StateProvider.autoDispose.family<DateTime, PersonalEvent?>(
        (ref, event){
          final personalEvent = ref.read(personalEventFormStateProvider(event));
          DateTime date = personalEvent.endDate ?? personalEvent.from!.add(const Duration(days: 7));
          return date;
        }
);

final repeatCheck = StateProvider.autoDispose.family<int, PersonalEvent?>(
        (ref, event){
          final personalEvent = ref.read(personalEventFormStateProvider(event));
          return personalEvent.repeat!;
        }
);