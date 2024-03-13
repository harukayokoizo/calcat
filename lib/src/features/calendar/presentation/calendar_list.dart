import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:share_calendar/src/features/calendar/presentation/published_list.dart';

import 'favorite_list.dart';
import 'form/calendar_form.dart';

class CalendarList extends StatelessWidget{
  const CalendarList({super.key});

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
                Tab(text: 'お気に入り'),
                Tab(text: '公開カレンダー'),
              ],
            )
          ),
          body: const TabBarView(
            children: [
              FavoriteCalendarList(),
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
        )
    );
  }
}