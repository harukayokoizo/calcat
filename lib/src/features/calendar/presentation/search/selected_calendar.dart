import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_calendar/src/features/calendar/domain/calendar_document.dart';
import '../../application/favorite_provider.dart';
import '../../application/search_provider.dart';
import '../../data/calendar_user_repositories.dart';
import '../calendar_info/detail/description_widget.dart';
import '../calendar_info/detail/icon_widget.dart';
import '../calendar_info/detail/title_widget.dart';

class SelectedCalendar extends ConsumerWidget{
  final CalendarDocument calendarDoc;
  const SelectedCalendar(this.calendarDoc, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref){
    final double deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        top: false,
        bottom: false,
        child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: SizedBox(
                      child: Column(children: [
                        CalendarIconWidget(calendarDoc.calendar!),
                        CalendarTitleWidget(calendarDoc.calendar!),
                        CalendarDescriptionWidget(calendarDoc.calendar!),
                      ],)
                  ),
                ),
              ),
              Material(
                elevation: 20,
                child: SizedBox(
                  width: deviceWidth,
                  child: followButton(calendarDoc.docId!),
                ),
              )
            ]
        ),
      ),
      floatingActionButton: null
    );
  }
}

Widget followButton(String docId){
  return Padding(
    padding: const EdgeInsets.only(bottom: 30, left: 30, right: 30),
    child: Consumer(
      builder: (context, ref, _) {
        final follow = ref.watch(getFollowCalendar(docId));
        return follow.when(
            data: (value){
              if(!value){
                return TextButton(
                  onPressed: (){
                    ref.read(calendarUserRepositories).createCalendarUser(docId);
                    ref.refresh(getFollowCalendar(docId).future);
                  },
                  style: TextButton.styleFrom(
                      backgroundColor: Colors.purple,
                      fixedSize: const Size(0,50),
                  ),
                  child: const Text(
                    'フォローする',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              }else{
                return TextButton(
                  onPressed: (){
                    ref.read(calendarUserRepositories).deleteFollowCalendar(docId);
                    ref.refresh(getFollowCalendar(docId).future);
                  },
                  style: TextButton.styleFrom(
                      backgroundColor: Colors.purple,
                      fixedSize: const Size(0,50),
                  ),
                  child: const Text(
                    'フォロー解除',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              }
            },
            error: (err, stack) => const SizedBox(),
            loading: () => const Center(child: CircularProgressIndicator())
        );
      }
    ),
  );
}