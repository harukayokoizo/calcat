import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_calendar/src/features/calendar/presentation/list/published_calendar/published_list.dart';
import '../../../tab_value/application/tab_value_provider.dart';
import '../../../tab_value/data/tab_value_repositories.dart';
import '../../../tab_value/domain/tab_value.dart';
import 'follow_calendar/follow_list.dart';
import '../calendar_info/create/calendar_form.dart';

class AllCalendarList extends ConsumerStatefulWidget{
  const AllCalendarList({super.key});

  @override
  ConsumerState<AllCalendarList> createState() => AllCalendarListState();
}

class AllCalendarListState extends ConsumerState<AllCalendarList> with TickerProviderStateMixin{
  late TabController tabController = TabController(length: 2, vsync: this);
  late final TabValue? tabValue;
  int currentIndex = 1;

  @override
  void initState() {
    super.initState();
    tabValue = ref.read(tabValueProvider);
    if(tabValue != null){
      currentIndex = tabValue!.listTabIndex!;
      tabController.index = currentIndex;
    }
  }



  @override
  Widget build(BuildContext context){
    return GestureDetector(
      onHorizontalDragUpdate: (details) {},
      onHorizontalDragEnd: (details) async {
          if(details.primaryVelocity! < 0.0){
            if (tabValue != null) {
              await ref.read(tabValueRepositories).updateListTabIndex(tabValue!, 1);
            }
            setState(() {
              currentIndex = 1;
              tabController.index = 1;
            });
          }
          if(details.primaryVelocity! > 0.0){
            if (tabValue != null) {
              await ref.read(tabValueRepositories).updateListTabIndex(tabValue!, 0);
            }
            setState(() {
              currentIndex = 0;
              tabController.index = 0;
            });
          }
        },
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
            appBar: AppBar(
              toolbarHeight: 0.0,
                //backgroundColor: Color(0xFFFFFFFF),
                elevation: 3,
                bottom : TabBar(
                  controller: tabController,
                  onTap: (index) async{
                    if (tabValue != null) {
                      await ref.read(tabValueRepositories).updateListTabIndex(tabValue!, index);
                    }
                    setState(() {
                      currentIndex = index;
                    });
                  },
                  // unselectedLabelColor: Color(0xFFFFFFFF).computeLuminance() < 0.5 ? Colors.white : Colors.black,
                  // labelColor: Color(0xFFFFFFFF).computeLuminance() < 0.5 ? Colors.white : Colors.black,
                  tabs: const [
                    Tab(
                      text: 'フォローリスト',
                      iconMargin: EdgeInsets.only(bottom: 0.0),
                    ),
                    Tab(
                      text: '作成リスト',
                      iconMargin: EdgeInsets.only(bottom: 0.0),
                    ),
                  ],
                )
            ),
            body: IndexedStack(
              index: currentIndex,
              children: const [
                FollowCalendarList(),
                PublishedCalendarList(),
              ],
            ),
            // body: NestedScrollView(
            //   headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            //     return [
            //       SliverAppBar(
            //         toolbarHeight: 0,
            //         // //excludeHeaderSemantics: true,
            //         forceElevated: true,
            //         pinned: true,
            //         // floating: true,
            //         // snap: true,
            //         bottom: TabBar(
            //           onTap: (index) {
            //             setState(() {
            //               currentIndex = index;
            //             });
            //           },
            //           tabs: const [
            //             Tab(text: 'フォローリスト'),
            //             Tab(text: '作成リスト'),
            //           ],
            //         ),
            //         // bottom:
            //       ),
            //     ];
            //   },
            //   body: IndexedStack(
            //     index: currentIndex,
            //     children: const [
            //       FollowCalendarList(),
            //       PublishedCalendarList(),
            //     ],
            //   ),
            // ),
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
      ),
    );
  }
}