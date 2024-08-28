import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_calendar/src/features/calendar/presentation/calendar_info/create/icon_form.dart';
import 'package:share_calendar/src/features/calendar/presentation/calendar_info/create/password_form.dart';
import 'package:share_calendar/src/features/calendar/presentation/calendar_info/create/public_preference_form.dart';
import 'package:share_calendar/src/features/calendar/presentation/calendar_info/create/title_form.dart';

import '../../../../../common_widgets/application/common_provider.dart';
import '../../../application/calendar_provider.dart';
import '../../../domain/calendar.dart';
import 'description_form.dart';
import 'link_form.dart';

class CalendarForm extends ConsumerStatefulWidget{
  const CalendarForm({super.key});

  @override
  CalendarFormState createState() => CalendarFormState();
}

class CalendarFormState extends ConsumerState<CalendarForm>{
  bool loading = false;

  @override
  Widget build(BuildContext context){
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double deviceHeight = MediaQuery.of(context).size.height;
    final user = ref.read(currentUserProvider);
    Calendar calendar = Calendar(
      author: user!.uid,
      title: null,
      description: null,
      image: null,
      fileName: null,
      publicPreference: 0,
      calendarLink: [],
      password: null,
      created: null,
      updated: null,
    );
    Calendar calendarState = ref.watch(calendarStateProvider(calendar));
    return Stack(
      children: [
        Scaffold(
          backgroundColor: const Color(0xFFF5F5F5),
          appBar: AppBar(
            elevation: 3,
            leading: IconButton(
              onPressed: (){
                Navigator.pop(context);
              },
              icon: const Icon(Icons.close),
            ),
            title: const Text(
              'カレンダー作成',
              style: TextStyle(fontSize: 18),
            ),
            centerTitle: true,
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: GestureDetector(
                  onTap: calendarState.title == null || calendarState.title!.isEmpty
                      || calendarState.description == null || calendarState.description!.isEmpty ? null : (){
                    setState(() {loading = true;});
                    try{
                      ref.read(calendarStateProvider(calendar).notifier).createCalendar().then((value){
                        setState(() {loading = false;});
                        if(value != null){
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: Colors.red,
                              content: Text(
                                value,
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          );
                        }else{
                          Navigator.of(context).pop(true);
                        }
                      });
                    }catch (e){
                      setState(() {loading = false;});
                    }

                  },
                  child: Text(
                    "保存",
                    style: TextStyle(
                        fontSize: 20,
                        color: calendarState.title == null || calendarState.title!.isEmpty
                            || calendarState.description == null || calendarState.description!.isEmpty ? Colors.grey : Colors.blue,
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
                  CalendarLinkForm(calendar),
                  PublicPreferenceForm(calendar),
                  PasswordForm(calendar),
                  const SizedBox(height: 45,),
                ]
              ),
            ),
          ),
        ),
        if(loading)
          Container(
            height: deviceHeight,
            width: deviceWidth,
            color: Colors.black.withOpacity(0.5),
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          ),
      ],
    );
  }
}