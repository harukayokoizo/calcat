import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_calendar/src/features/personal_event/application/event_provider.dart';

import '../domain/event.dart';

final colorList = StateProvider<List<int>>(
        (ref) => [
          0xFFADFF2F,
          0xFF32CD32,
          0xFF00BFFF,
          0xFF1E90FF,
          0xFFFF69B4,
          0xFFFF0000,
          0xFFA9A9A9,
          0xFF808080,
          0xFF000000,
        ]
);

final colorCheck = StateProvider.autoDispose.family<int,Event>(
        (ref, event){
          final personalEvent = ref.read(eventFormStateProvider(event));
          return personalEvent.color!;
        }
);