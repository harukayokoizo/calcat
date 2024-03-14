import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_calendar/src/features/calendar/presentation/form/password_form.dart';
import 'package:share_calendar/src/features/calendar/presentation/form/public_preference_form.dart';
import 'package:share_calendar/src/features/calendar/presentation/form/title_form.dart';

import '../../application/calendar_state_provider.dart';
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
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Padding(
              padding: EdgeInsets.only(right: 16.0),
              child: Text(
                "保存",
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.grey,
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