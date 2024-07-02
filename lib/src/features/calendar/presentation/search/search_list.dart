import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../search_value/application/search_value_list_provider.dart';
import '../../application/search_provider.dart';
import '../../data/calendar_repositories.dart';

class SearchCalendarList extends ConsumerWidget{
  const SearchCalendarList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref){
    final searchPageState = ref.read(searchPageProvider);
    final searchCalendarList = ref.watch(searchCalendarListProvider(searchPageState.text!));
    return searchCalendarList.when(
        data: (calendarList){
          if(calendarList.isNotEmpty) {
            return ListView.builder(
                itemCount: calendarList.length,
                itemBuilder: (BuildContext context, int index) {
                  String? title = calendarList[index].calendar!.title!;
                  return ListTile(
                    leading: const Icon(Icons.search),
                    trailing: Transform.rotate(
                      angle: -45,
                      child: const Icon(Icons.arrow_upward, color: Colors.blue,),
                    ),
                    onTap: (){
                      final searchState = ref.read(searchPageProvider);
                      ref.read(searchPageProvider.notifier).saveState(searchState.copyWith(selectedText: title));
                      FocusScope.of(context).requestFocus(FocusNode());
                      ref.read(searchResultsProvider.notifier).searchCalendar(title).then((value){
                        ref.read(searchPageProvider.notifier).saveState(searchState.copyWith(result: true));
                      });
                    },
                    title: Text(title),
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