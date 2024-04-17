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

class FollowList extends StatefulWidget{
  List<CalendarUser> calendarList;
  FollowList(this.calendarList, {super.key});

  @override
  State<FollowList> createState() => FollowListState();
}

class FollowListState extends State<FollowList> with SingleTickerProviderStateMixin{
  late final controller = SlidableController(this);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        controller.close();
      },
      child: ListView.builder(
        itemCount: widget.calendarList.length,
        itemBuilder: (BuildContext context, int index){
          return Slidable(
              key: const ValueKey(0),
              controller: controller,
              endActionPane: ActionPane( // (2)
                extentRatio: 0.25,
                motion: const ScrollMotion(), // (5)
                children: [
                  SlidableAction(
                    onPressed: (_) {
                      showCupertinoDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return FollowCalendarDeleteDialog(widget.calendarList[index]);
                        },
                      ).then((value){
                        if(value){
                          controller.close();
                        }
                      });
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
        // children: [
        //   for(CalendarUser calendarDoc in calendarList)
        //     FollowCalendar(calendarDoc)
        // ],
      ),
    );
  }
}

class FollowCalendar extends ConsumerWidget{
  CalendarUser calendar;
  FollowCalendar(this.calendar, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final followList = ref.watch(calendarUserRepositories).getFollowCalendarDocument(calendar.calendar!);
    return FutureBuilder<CalendarDocument?>(
      future: followList,
      builder: (BuildContext context, AsyncSnapshot<CalendarDocument?> snapshot) {
        if(snapshot.hasData){
          return FollowCalendarContent(snapshot.data!);
        }
        return const SizedBox();
      },
    );
  }
}