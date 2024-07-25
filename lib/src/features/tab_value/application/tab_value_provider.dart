import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/tab_value_repositories.dart';
import '../domain/tab_value.dart';

final tabValueProvider = StateNotifierProvider<TabValueProviderState, TabValue?>(
        (ref){
          return TabValueProviderState(ref);
        }
);

class TabValueProviderState extends StateNotifier<TabValue?>{
  Ref ref;

  TabValueProviderState(this.ref) : super(TabValue());

  Future<TabValue?> getTabValue() async{
    final TabValue? tabValue = await ref.read(tabValueRepositories).controlTabValue();
    state = tabValue;

    return state;
  }
}
