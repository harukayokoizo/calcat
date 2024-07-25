import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_calendar/src/features/event/application/event_provider.dart';

import '../domain/event.dart';

final colorList = StateProvider<List<Map<String, int>>>(
        (ref) => [
          {'key': 0, 'color' : 0xFFFF8000},//オレンジ
          {'key': 1, 'color' : 0xFFFF0000},//赤
          {'key': 2, 'color' : 0xFFdc143c},//濃赤
          {'key': 3, 'color' : 0xFF32CD32},//緑
          {'key': 4, 'color' : 0xFF008000},//濃緑
          {'key': 5, 'color' : 0xFF008080},//緑
          {'key': 6, 'color' : 0xFF1E90FF},//水色
          {'key': 7, 'color' : 0xFF4169e1},//青色
          {'key': 8, 'color' : 0xFF0000cd},//青色
          {'key': 9, 'color' : 0xFFFF69B4},//ピンク
          {'key': 10, 'color' : 0xFFb300ff},//紫色
          {'key': 11, 'color' : 0xFF800080},//紫色
          {'key': 12, 'color' : 0xFF808080},//灰色
          {'key': 13, 'color' : 0xFF000000},//黒
        ]
);

/*
          {'key': 0, 'color' : 0xFFe60033},//赤
          {'key': 1, 'color' : 0xFFd70035},//緋色
          {'key': 2, 'color' : 0xFFa22041},//濃紅
          {'key': 3, 'color' : 0xFFbb5535},//赤茶
          {'key': 4, 'color' : 0xFF007b43},//常磐緑
          {'key': 5, 'color' : 0xFF00552e},//深緑
          {'key': 6, 'color' : 0xFF007bbb},//紺碧
          {'key': 7, 'color' : 0xFF4c6cb3},//群青色
          {'key': 8, 'color' : 0xFF4d5aaf},//花色
          {'key': 9, 'color' : 0xFF4d5aaf},//青紫
          {'key': 10, 'color' : 0xFF884898},//紫
          {'key': 11, 'color' : 0xFFb44c94},//紅紫
          {'key': 12, 'color' : 0xFF727171},//鈍色
          {'key': 13, 'color' : 0xFFadff2f},//暗黒色
 */

final colorCheck = StateProvider.autoDispose.family<int,Event>(
        (ref, event){
          final personalEvent = ref.read(eventFormStateProvider(event));
          return personalEvent.color!;
        }
);