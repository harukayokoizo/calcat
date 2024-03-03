import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_calendar/src/features/personal_event/application/personal_event_provider.dart';

final repeatList = StateProvider<List<dynamic>>(
        (ref) => [
          'なし',
          '毎日',
          '毎週',
          '毎月'
        ]
);

final repeatEndDate = StateProvider.autoDispose<DateTime>(
        (ref){
          final personalEvent = ref.read(personalEventFormStateProvider);
          return personalEvent.from!;
        }
);