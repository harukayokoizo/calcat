
import 'package:flutter_riverpod/flutter_riverpod.dart';

final searchSwitch = StateNotifierProvider<SearchSwitch, bool>(
        (ref) => SearchSwitch()
);

class SearchSwitch extends StateNotifier<bool>{
  SearchSwitch() : super(false);

  void switchState(bool value){
    state = value;
  }
}