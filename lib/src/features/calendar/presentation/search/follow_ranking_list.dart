import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_calendar/src/features/calendar/presentation/search/searched_calendar_content.dart';

import '../../application/search_provider.dart';
import '../../domain/calendar_document.dart';

class FollowRankingList extends ConsumerWidget{
  const FollowRankingList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref){
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double deviceHeight = MediaQuery.of(context).size.height;
    final calendarList = ref.watch(followRankingListProvider);
    return calendarList.when(
        data: (calendarList){
          if(calendarList.isNotEmpty) {
            return RefreshIndicator(
              onRefresh: () async{
                await ref.refresh(followRankingListProvider.future);
              },
              child: SizedBox(
                height: deviceHeight,
                width: deviceWidth,
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 20.0, top: 20.0, bottom: 10.0),
                        child: Text(
                          'Topカレンダー',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: calendarList.length,
                          itemBuilder: (BuildContext context, int index) {
                            CalendarDocument calendarDoc = calendarList[index];
                            return SearchedCalendarContent(calendarDoc);
                          }),
                      const SizedBox(height: 30,),
                    ],
                  ),
                ),
              ),
            );
          }else{
            return Center(
              child: SizedBox(
                height: deviceWidth / 1.5,
                width: deviceWidth / 1.5,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      width: deviceWidth / 3,
                      height: deviceWidth / 3,
                      'images/calcat.png',
                      fit: BoxFit.cover,
                    ),
                    RichText(
                      textAlign: TextAlign.center,
                      text: const TextSpan(
                        style: TextStyle(color: Colors.black),
                        children: [
                          TextSpan(
                            text: 'まだ何もありません\n',
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                          TextSpan(
                            text: '公開されているカレンダーがここに表示されます。',
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
        },
        error: (error,st) => const SizedBox(),
        loading: () => const SizedBox()
    );
  }
}