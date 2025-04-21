import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '../../../domain/calendar_user.dart';
import '../../../application/calendar_list_provider.dart';
import '../../../data/calendar_user_repositories.dart';
import '../../../domain/calendar_document.dart';
import '../../calendar_info/edit/delete_dialog.dart';
import '../published_calendar/published_calendar_content.dart';
import 'follow_calendar_content.dart';

class FollowCalendarList extends ConsumerWidget{
  User? user;
  FollowCalendarList(this.user, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref){
    var calendar = ref.watch(followCalendarList(user));
    return calendar.when(
      error: (err, _) => const SizedBox(), //エラー時
      loading: () => const SizedBox(), //読み込み時
      data: (data) => FollowList(data), //データ受け取り時
    );
  }
}

class FollowList extends StatefulWidget{
  final List<CalendarUser> calendarList;
  const FollowList(this.calendarList, {super.key});

  @override
  State<FollowList> createState() => FollowListState();
}

class FollowListState extends State<FollowList> with SingleTickerProviderStateMixin{
  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double deviceHeight = MediaQuery.of(context).size.height;
    return SizedBox(
      height: deviceHeight,
      width: deviceWidth,
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          children: [
            SlidableAutoCloseBehavior(
              child: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: widget.calendarList.length,
                itemBuilder: (BuildContext context, int index){
                  return Slidable(
                      key: ValueKey(index),
                      endActionPane: ActionPane(
                        extentRatio: 0.25,
                        motion: const ScrollMotion(),
                        children: [
                          SlidableAction(
                            onPressed: (_) {
                              showCupertinoDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return FollowCalendarDeleteDialog(widget.calendarList[index]);
                                },
                              );
                            },
                            backgroundColor: Colors.red,
                            //foregroundColor: Colors.red,
                            icon: Icons.delete,
                            label: '削除',
                          ),
                        ],
                      ),
                      child: FollowCalendar(widget.calendarList[index])
                  );
                },
              ),
            ),
            const SizedBox(height: 30,),
          ],
        ),
      ),
    );
  }
}

class FollowCalendar extends ConsumerWidget{
  final CalendarUser calendar;
  const FollowCalendar(this.calendar, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final followList = ref.watch(calendarUserRepositories).getFollowCalendarDocument(calendar.calendar!);
    return FutureBuilder<CalendarDocument?>(
      future: followList,
      builder: (BuildContext context, AsyncSnapshot<CalendarDocument?> snapshot) {
        if(snapshot.hasData){
          return FollowCalendarContent(snapshot.data!);
        }else {
          return const SizedBox();
        }
      },
    );
  }
}