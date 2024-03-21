import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_calendar/src/features/calendar/presentation/calendar/list/published_list.dart';

import '../../../../personal_event/domain/calendar_user.dart';
import '../../../application/calendar_list_provider.dart';
import '../../../data/calendar_user_repositories.dart';
import '../../../domain/calendar_document.dart';
import 'calendar_content.dart';

class FollowCalendarList extends ConsumerWidget{
  const FollowCalendarList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref){
    final calendar = ref.watch(followCalendarList);
    return calendar.when(
      error: (err, _) => const SizedBox(), //エラー時
      loading: () => const SizedBox(), //読み込み時
      data: (data) => FollowList(data), //データ受け取り時
    );
  }
}

class FollowList extends StatelessWidget{
  List<CalendarUser> calendarList;

  FollowList(this.calendarList, {super.key});

  @override
  Widget build(BuildContext context) {
    print(calendarList);
    return Column(
      children: [
        for(CalendarUser calendarDoc in calendarList)
          FollowCalendarContent(calendarDoc)
      ],
    );
  }
}

class FollowCalendarContent extends ConsumerWidget{
  CalendarUser calendar;
  FollowCalendarContent(this.calendar, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final followList = ref.watch(calendarUserRepositories).getFollowCalendarDocument(calendar.calendar!);
    return FutureBuilder<CalendarDocument?>(
      future: followList,
      builder: (BuildContext context, AsyncSnapshot<CalendarDocument?> snapshot) {
        if(snapshot.hasData){
          return CalendarContent(snapshot.data!);
        }
        return const SizedBox();
      },
    );
  }
}