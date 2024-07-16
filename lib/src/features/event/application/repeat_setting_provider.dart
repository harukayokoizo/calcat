import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_calendar/src/features/event/application/event_provider.dart';

import '../domain/event.dart';

final repeatList = StateProvider<List<dynamic>>(
        (ref) => [
          'なし',
          '毎日',
          '毎週',
          //'毎月'
        ]
);

final repeatEndDate = StateProvider.autoDispose.family<DateTime, Event>(
        (ref, event){
          final personalEvent = ref.read(eventFormStateProvider(event));
          DateTime date = personalEvent.endDate ?? personalEvent.from!.add(const Duration(days: 7));
          return date;
        }
);

final repeatCheck = StateProvider.autoDispose.family<int, Event>(
        (ref, event){
          final personalEvent = ref.read(eventFormStateProvider(event));
          return personalEvent.repeat!;
        }
);