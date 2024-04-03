import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../search_value/application/search_value_list_provider.dart';
import '../../application/search_provider.dart';
import '../../data/calendar_repositories.dart';

class SearchCalendarList extends ConsumerWidget{
  SearchCalendarList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref){
    final value = ref.watch(searchValue);
    final searchCalendarList = ref.watch(searchCalendarListProvider(value!));
    return searchCalendarList.when(
        data: (calendarList){
          if(calendarList.isNotEmpty) {
            return ListView.builder(
                itemCount: calendarList.length,
                itemBuilder: (BuildContext context, int index) {
                  String? title = calendarList[index].calendar!.title!;
                  return ListTile(
                      onTap: (){
                        FocusScope.of(context).requestFocus(FocusNode());
                        ref.read(searchValue.notifier).tapSearchValue(title);
                        ref.read(searchResultsProvider.notifier).searchCalendar(title).then((value){
                          ref.read(resultPage.notifier).resultPage(true);
                        });
                      },
                      title: Text(title)
                  );
                });
          }else{
            return const SizedBox();
          }
        },
        error: (error,st) => const SizedBox(),
        loading: () => const SizedBox()
    );
  }
}