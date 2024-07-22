import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../application/calendar_provider.dart';
import '../../../domain/calendar.dart';

class PublicPreferenceForm extends ConsumerWidget{
  Calendar calendar;
  PublicPreferenceForm(this.calendar, {super.key});

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
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          RadioListTile(
            title: const Text('公開しない'),
            value: noPublic,
            groupValue: 1,
            controlAffinity: ListTileControlAffinity.trailing,
            visualDensity: const VisualDensity(vertical: -2),
            //contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16.0),
            onChanged: (value) {
              ref.read(calendarStateProvider(calendar).notifier).savePublicPreference(0);
            },

          ),
          RadioListTile(
            title: const Text('全ユーザーに公開'),
            value: allUser,
            groupValue: 1,
            controlAffinity: ListTileControlAffinity.trailing,
            visualDensity: const VisualDensity(vertical: -2),
            //contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16.0),
            onChanged: (value) {
              ref.read(calendarStateProvider(calendar).notifier).savePublicPreference(1);
            },

          ),
          RadioListTile(
            title: const Text('限定公開'),
            value: limitUser,
            groupValue: 1,
            controlAffinity: ListTileControlAffinity.trailing,
            visualDensity: const VisualDensity(vertical: -2),
            onChanged: (value) {
              ref.read(calendarStateProvider(calendar).notifier).savePublicPreference(2);
            },

          ),
        ],
      ),
    );
  }
}