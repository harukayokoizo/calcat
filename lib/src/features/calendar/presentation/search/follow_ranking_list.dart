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
    final calendarList = ref.watch(followRankingListProvider);
    return calendarList.when(
        data: (calendarList){
          if(calendarList.isNotEmpty) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 16.0, top: 20.0, bottom: 10.0),
                  child: Text(
                    'フォロー数ランキング',
                    style: TextStyle(
                      fontSize: 18,
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
              ],
            );
          }else{
            return const SizedBox();
          }
        },
        error: (error,st) => const SizedBox(),
        loading: () => const SizedBox()
    );
  }
}