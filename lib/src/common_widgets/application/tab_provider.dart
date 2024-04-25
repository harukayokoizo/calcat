// bottomTab
import 'package:flutter_riverpod/flutter_riverpod.dart';

final bottomTabProvider = StateNotifierProvider<BottomTabState, int>(
        (ref) {
      return BottomTabState();
    }
);

class BottomTabState extends StateNotifier<int>{
  BottomTabState() : super(2);

  void changeTab(int index) => state = index;
}