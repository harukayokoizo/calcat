import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../application/calendar_state_provider.dart';
import '../../domain/calendar.dart';

class PasswordForm extends ConsumerWidget{
  Calendar? calendar;
  PasswordForm({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref){
    final state = ref.read(calendarStateProvider(calendar));
    final initialText = state.password ?? '';
    if(state.publicPreference!){
      return const SizedBox();
    }else {
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'パスワード',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              initialValue: initialText,
              decoration: const InputDecoration(
                //hintText: 'イベント名',
                //border: InputBorder.none
              ),
              onChanged: (value) {
                ref.read(calendarStateProvider(calendar).notifier).savePassword(
                    value);
              },
            ),
          )
        ],
      );
    }
  }
}