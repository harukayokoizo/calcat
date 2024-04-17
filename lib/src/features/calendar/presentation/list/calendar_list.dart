import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:share_calendar/src/features/calendar/presentation/list/published_calendar/published_list.dart';
import 'follow_calendar/follow_list.dart';
import '../calendar_info/create/calendar_form.dart';

class AllCalendarList extends StatelessWidget{
  const AllCalendarList({super.key});

  @override
  Widget build(BuildContext context){
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            elevation: 3,
              title: const Text('カレンダー一覧'),
              centerTitle: true,
            bottom : const TabBar(
              tabs: [
                Tab(text: 'フォローリスト'),
                Tab(text: '公開カレンダー'),
              ],
            )
          ),
          body: const TabBarView(
            children: [
              FollowCalendarList(),
              PublishedCalendarList()
            ],
          ),
          floatingActionButton: FloatingActionButton(
            heroTag: "add calendar",
            child: Icon(Icons.add),
            //backgroundColor: Colors.blue[200],
            onPressed: () async {
              showCupertinoModalPopup(
                  context: context,
                  builder: (BuildContext context) => CalendarForm()
              );
            },
          ),
        )
    );
  }
}