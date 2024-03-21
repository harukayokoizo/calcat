import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:share_calendar/src/features/calendar/presentation/calendar/list/published_list.dart';

import 'follow_list.dart';
import '../../form/calendar_form.dart';

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
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CalendarForm(),
                ),
              );
            },
          ),
          // bottomNavigationBar: BottomNavigationBar(
          //   // ignore: invalid_use_of_protected_member
          //   items: const [
          //     BottomNavigationBarItem(
          //       icon: Icon(Icons.search),
          //       label: 'Search',
          //     ),
          //     BottomNavigationBarItem(
          //       icon: Icon(Icons.star),
          //       label: 'Calendar',
          //     ),
          //     BottomNavigationBarItem(
          //       icon: Icon(Icons.calendar_month),
          //       label: 'My Calendar',
          //     ),
          //   ],
          // ),
        )
    );
  }
}