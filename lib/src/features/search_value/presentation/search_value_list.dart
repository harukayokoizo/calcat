import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../calendar/application/search_provider.dart';
import '../application/search_value_list_provider.dart';
import '../data/search_value_repositories.dart';

class SearchValueList extends ConsumerWidget{
  const SearchValueList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref){
    final searchValueList = ref.watch(searchValueListProvider);
    return searchValueList.when(
        data: (valueList){
          if(valueList.isNotEmpty) {
            return ListView.builder(
                itemCount: valueList.length,
                itemBuilder: (BuildContext context, int index) {
                  String title = valueList[index]!;
                  return ListTile(
                    leading: const Icon(Icons.search),
                    trailing: Transform.rotate(
                      angle: -45,
                      child: const Icon(Icons.arrow_upward, color: Colors.blue,),
                    ),
                    onTap: (){
                      FocusScope.of(context).requestFocus(FocusNode());
                      ref.read(searchValue.notifier).tapSearchValue(title);
                      ref.read(searchResultsProvider.notifier).searchCalendar(title).then((value){
                        ref.read(resultPage.notifier).resultPage(true);
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