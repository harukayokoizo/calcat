import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

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
            return SlidableAutoCloseBehavior(
              child: ListView.builder(
                  itemCount: valueList.length,
                  itemBuilder: (BuildContext context, int index) {
                    String searchValue = valueList[index]!;
                    return Slidable(
                      key: ValueKey(index),
                      endActionPane: ActionPane(
                        extentRatio: 0.25,
                        motion: const ScrollMotion(),
                        children: [
                          SlidableAction(
                            onPressed: (_) async{
                              await ref.read(searchValueRepositories).deleteSingleSearchValue(searchValue);
                              await ref.refresh(searchValueListProvider.future);
                            },
                            backgroundColor: Colors.red,
                            icon: Icons.delete,
                            label: '削除',
                          ),
                        ],
                      ),
                      child: ListTile(
                        leading: const Icon(Icons.search),
                        trailing: Transform.rotate(
                          angle: -45,
                          child: const Icon(Icons.arrow_upward, color: Colors.blue,),
                        ),
                        onTap: (){
                          final searchState = ref.read(searchPageProvider);
                          ref.read(searchPageProvider.notifier).saveState(searchState.copyWith(selectedText: searchValue));
                          FocusScope.of(context).requestFocus(FocusNode());
                          ref.read(searchResultsProvider.notifier).searchCalendar(searchValue).then((value){
                            ref.read(searchPageProvider.notifier).saveState(searchState.copyWith(result: true));
                          });
                        },
                        title: Text(searchValue),
                      ),
                    );
                  }),
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