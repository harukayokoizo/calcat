import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../application/calendar_provider.dart';
import '../../../domain/calendar.dart';

class PublicPreferenceForm extends ConsumerWidget{
  final Calendar calendar;
  const PublicPreferenceForm(this.calendar, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref){
    final state = ref.read(calendarStateProvider(calendar));
    int noPublic = 0;
    int allUser = 0;
    int limitUser = 0;
    if(state.publicPreference == 0){
      noPublic = 1;
    }else if(state.publicPreference == 1){
      allUser = 1;
    }else{
      limitUser = 1;
    }

    return Padding(
      padding: const EdgeInsets.only(top: 10, right: 30, left: 30, bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(bottom: 10.0),
            child: Text(
              '公開設定',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          RadioListTile(
            title: const Text('公開しない', style: TextStyle(fontSize: 14),),
            value: noPublic,
            groupValue: 1,
            controlAffinity: ListTileControlAffinity.trailing,
            visualDensity: const VisualDensity(vertical: -4),
            //contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16.0),
            onChanged: (value) {
              ref.read(calendarStateProvider(calendar).notifier).savePublicPreference(0);
            },

          ),
          RadioListTile(
            title: const Text('全ユーザーに公開', style: TextStyle(fontSize: 14),),
            value: allUser,
            groupValue: 1,
            controlAffinity: ListTileControlAffinity.trailing,
            visualDensity: const VisualDensity(vertical: -4),
            //contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16.0),
            onChanged: (value) {
              ref.read(calendarStateProvider(calendar).notifier).savePublicPreference(1);
            },

          ),
          RadioListTile(
            title: const Text('限定公開', style: TextStyle(fontSize: 14),),
            value: limitUser,
            groupValue: 1,
            controlAffinity: ListTileControlAffinity.trailing,
            visualDensity: const VisualDensity(vertical: -4),
            onChanged: (value) {
              ref.read(calendarStateProvider(calendar).notifier).savePublicPreference(2);
            },

          ),
        ],
      ),
    );
  }
}