import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_calendar/src/features/calendar/presentation/form/password_form.dart';
import 'package:share_calendar/src/features/calendar/presentation/form/public_preference_form.dart';
import 'package:share_calendar/src/features/calendar/presentation/form/title_form.dart';

import '../../application/calendar_provider.dart';
import 'description_form.dart';
import 'icon_form.dart';

class CalendarForm extends ConsumerWidget{
  const CalendarForm({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref){
    final calendar = ref.watch(calendarStateProvider(null));
    print(calendar);
    return Scaffold(
      appBar: AppBar(
        elevation: 3,
        title: const Text('カレンダー作成'),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              onTap: calendar.title == null || calendar.title!.isEmpty ? null : (){
                ref.read(calendarStateProvider(null).notifier).createCalendar()
                    .then((value){
                          Navigator.of(context).pop(true);
                    });
              },
              child: Text(
                "保存",
                style: TextStyle(
                    fontSize: 20,
                    color: calendar.title == null || calendar.title!.isEmpty ? Colors.grey : Colors.blue,
                    fontWeight: FontWeight.w700
                ),
              ),
            ),
          ),
        ],
      ),
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: (){
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              IconForm(),
              CalendarTitleForm(),
              DescriptionForm(),
              PublicPreferenceForm(),
              PasswordForm()
            ]
          ),
        ),
      ),
    );
  }
}