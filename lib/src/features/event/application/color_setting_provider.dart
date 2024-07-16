import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_calendar/src/features/event/application/event_provider.dart';

import '../domain/event.dart';

final colorList = StateProvider<List<int>>(
        (ref) => [
          0xFFFF0000,//赤
          0xFFFF8000,//オレンジ
          0xFF32CD32,//緑
          0xFF00BFFF,//水色
          0xFF1E90FF,//青色
          0xFFb300ff,//紫色
          0xFFFF69B4,//ピンク
          0xFF808080,//灰色
          0xFF000000,//黒
        ]
);

final colorCheck = StateProvider.autoDispose.family<int,Event>(
        (ref, event){
          final personalEvent = ref.read(eventFormStateProvider(event));
          return personalEvent.color!;
        }
);