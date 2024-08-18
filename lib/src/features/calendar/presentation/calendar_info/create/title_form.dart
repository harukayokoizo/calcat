import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../application/calendar_provider.dart';
import '../../../domain/calendar.dart';


class CalendarTitleForm extends ConsumerWidget{
  final Calendar calendar;
  const CalendarTitleForm(this.calendar, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref){
    final initialTitle = calendar.title;
    return Padding(
      padding: const EdgeInsets.only(top: 20, right: 30, left: 30, bottom: 0.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(bottom: 10.0),
            child: Text(
              'カレンダー情報',
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
            initialValue: initialTitle,
            maxLength: 18,
            buildCounter: (BuildContext context, {int? currentLength, int? maxLength, bool? isFocused}) {
              return null; // カウンターを非表示にします
            },
            decoration: const InputDecoration(
              fillColor: Colors.white,
              filled: true,
              border:OutlineInputBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10.0),
                    topRight: Radius.circular(10.0),
                  ),
                  borderSide: BorderSide.none
              ),
              contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10)
            ),
            onChanged: (value){
              ref.read(calendarStateProvider(calendar).notifier).saveTitle(value);
            },
          )
        ],
      ),
    );
  }
}