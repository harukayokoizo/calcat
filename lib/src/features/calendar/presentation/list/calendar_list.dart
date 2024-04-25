import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:share_calendar/src/features/calendar/presentation/list/published_calendar/published_list.dart';
import 'follow_calendar/follow_list.dart';
import '../calendar_info/create/calendar_form.dart';

class AllCalendarList extends StatefulWidget{
  const AllCalendarList({super.key});

  @override
  State<AllCalendarList> createState() => AllCalendarListState();
}

class AllCalendarListState extends State<AllCalendarList>{
  int currentIndex = 0;

  @override
  Widget build(BuildContext context){
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          body: NestedScrollView(
            headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
              return [
                SliverAppBar(
                  toolbarHeight: 0,
                  excludeHeaderSemantics: true,
                  forceElevated: true,
                  // centerTitle: true,
                  // title: Text(
                  //   'カレンダー一覧',
                  //   style: TextStyle(
                  //     fontWeight: FontWeight.bold,
                  //   ),
                  // ),
                  pinned: true,
                  floating: true,
                  snap: true,
                  bottom: TabBar(
                    onTap: (index) {
                      setState(() {
                        currentIndex = index;
                      });
                    },
                    tabs: const [
                      Tab(text: 'フォローリスト'),
                      Tab(text: '作成リスト'),
                    ],
                  ),
                  // bottom:
                ),
              ];
            },
            body: IndexedStack(
              index: currentIndex,
              children: const [
                FollowCalendarList(),
                PublishedCalendarList(),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.blue.shade500,
            shape: const CircleBorder(),
            heroTag: "add calendar",
            child: const Icon(Icons.add, color: Colors.white),
            //backgroundColor: Colors.blue[200],
            onPressed: () async {
              showCupertinoModalPopup(
                  context: context,
                  builder: (BuildContext context) => CalendarForm()
              );
            },
          ),
        ),
          // appBar: AppBar(
          //   backgroundColor: Color(0xFFFFFFFF),
          //   elevation: 3,
          //   title: Text(
          //       'カレンダー一覧',
          //     style: TextStyle(
          //       color: Color(0xFFFFFFFF).computeLuminance() < 0.5 ? Colors.white : Colors.black,
          //       fontWeight: FontWeight.bold,
          //     ),
          //   ),
          //   centerTitle: true,
          //   bottom : TabBar(
          //     unselectedLabelColor: Color(0xFFFFFFFF).computeLuminance() < 0.5 ? Colors.white : Colors.black,
          //     labelColor: Color(0xFFFFFFFF).computeLuminance() < 0.5 ? Colors.white : Colors.black,
          //     tabs: const [
          //       Tab(
          //         text: 'フォローリスト',
          //         iconMargin: EdgeInsets.only(bottom: 0.0),
          //       ),
          //       Tab(
          //         text: '作成リスト',
          //         iconMargin: EdgeInsets.only(bottom: 0.0),
          //       ),
          //     ],
          //   )
          // ),
          // body: const TabBarView(
          //   children: [
          //     FollowCalendarList(),
          //     PublishedCalendarList()
          //   ],
          // ),
    );
  }
}