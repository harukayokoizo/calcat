import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../application/search_value_list_provider.dart';
import '../data/search_value_repositories.dart';

class SearchValueList extends ConsumerWidget{
  const SearchValueList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref){
    final searchValueList = ref.read(searchValueListProvider);
    print(searchValueList);
    return searchValueList.when(
        data: (valueList){
          print(valueList);
          if(valueList.isNotEmpty) {
            return ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  String title = valueList[index]!;
                  return ListTile(
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