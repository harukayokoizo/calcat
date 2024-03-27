import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_calendar/src/features/calendar/presentation/form/password_form.dart';
import 'package:share_calendar/src/features/calendar/presentation/form/public_preference_form.dart';
import 'package:share_calendar/src/features/calendar/presentation/form/title_form.dart';

import '../../../../../application/calendar_provider.dart';
import '../../../../../domain/calendar.dart';
import '../../../../../domain/calendar_document.dart';
import '../../../../form/description_form.dart';
import '../../../../form/icon_form.dart';

class CalendarEditForm extends ConsumerWidget{
  CalendarDocument calendarDoc;
  CalendarEditForm(this.calendarDoc, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref){
    Calendar calendar = calendarDoc.calendar!;
    Calendar calendarState = ref.watch(calendarStateProvider(calendar));

    return Scaffold(
      appBar: AppBar(
        elevation: 3,
        title: const Text('カレンダー編集'),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              onTap: calendarState.title == null || calendarState.title!.isEmpty ? null : (){
                ref.read(calendarStateProvider(calendar).notifier).editCalendar(calendarDoc.docId!)
                    .then((value){
                      if(value != null){
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: Colors.red,
                            content: Text(
                              value,
                              style: const TextStyle(
                                fontSize: 15,
                              ),
                            ),
                          ),
                        );
                      }else{
                        Navigator.of(context).pop(true);
                      }
                    });
              },
              child: Text(
                "保存",
                style: TextStyle(
                    fontSize: 20,
                    color: calendarState.title == null || calendarState.title!.isEmpty ? Colors.grey : Colors.blue,
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
                IconForm(calendar),
                CalendarTitleForm(calendar),
                DescriptionForm(calendar),
                PublicPreferenceForm(calendar),
                PasswordForm(calendar)
              ]
          ),
        ),
      ),
    );
  }
}