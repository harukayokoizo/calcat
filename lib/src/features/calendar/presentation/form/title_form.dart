import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../application/calendar_state_provider.dart';
import '../../domain/calendar.dart';

class CalendarTitleForm extends ConsumerWidget{
  Calendar? calendar;
  CalendarTitleForm({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref){
    final state = ref.read(calendarStateProvider(calendar));
    final initialTitle = state.title ?? '';
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            '名前',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            initialValue: initialTitle,
            //controller: titleController,
            decoration: const InputDecoration(
                //hintText: 'イベント名',
                //border: InputBorder.none
            ),
            onChanged: (value){
              ref.read(calendarStateProvider(calendar).notifier).saveTitle(value);
            },
          ),
        )
      ],
    );
  }
}