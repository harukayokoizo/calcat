import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../application/calendar_provider.dart';
import '../../../domain/calendar.dart';

class PasswordForm extends ConsumerWidget{
  Calendar calendar;
  PasswordForm(this.calendar, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref){
    final state = ref.read(calendarStateProvider(calendar));
    final initialText = state.password ?? '';
    if(state.publicPreference != 2){
      return const SizedBox();
    }else {
      return Padding(
        padding: const EdgeInsets.only(top: 10, right: 30, left: 30, bottom: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(bottom: 5.0),
              child: Text(
                'パスワード',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            TextFormField(
              style: const TextStyle(
                fontSize: 15,
              ),
              cursorHeight: 18,
              initialValue: initialText,
              decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  border:OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide.none
                  ),
                  contentPadding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10)
              ),
              onChanged: (value) {
                ref.read(calendarStateProvider(calendar).notifier).savePassword(
                    value);
              },
            )
          ],
        ),
      );
    }
  }
}