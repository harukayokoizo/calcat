import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../application/calendar_provider.dart';
import '../../domain/calendar.dart';

class PublicPreferenceForm extends ConsumerWidget{
  Calendar? calendar;
  PublicPreferenceForm({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref){
    final state = ref.read(calendarStateProvider(calendar));
    int allUser;
    int limitUser;
    if(state.publicPreference!){
      allUser = 1;
      limitUser = 0;
    }else{
      allUser = 0;
      limitUser = 1;
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            '公開設定',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0),
          child: RadioListTile(
            title: const Text('全ユーザーに公開'),
            value: allUser,
            groupValue: 1,
            controlAffinity: ListTileControlAffinity.trailing,
            onChanged: (value) {
              ref.read(calendarStateProvider(calendar).notifier).savePublicPreference(true);
            },

          )
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0),
          child: RadioListTile(
            title: const Text('限定公開'),
            value: limitUser,
            groupValue: 1,
            controlAffinity: ListTileControlAffinity.trailing,
            onChanged: (value) {
              ref.read(calendarStateProvider(calendar).notifier).savePublicPreference(false);
            },

          )
        ),
      ],
    );
  }
}