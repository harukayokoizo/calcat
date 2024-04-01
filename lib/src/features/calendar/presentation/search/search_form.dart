import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../search_value/data/search_value_repositories.dart';
import '../../application/search_provider.dart';
import '../../data/calendar_repositories.dart';

class SearchForm extends ConsumerWidget{
  final TextEditingController controller = TextEditingController();

  SearchForm({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref){
    ref.read(searchValueRepositories).connectIsar();
    return Row(
        children: [
          Expanded(
            child: TextFormField(
              //initialValue: initialTitle,
              controller: controller,
              decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: IconButton(
                    onPressed: (){
                      controller.clear();
                      ref.watch(textControllerProvider.notifier).switchState(false);
                    },
                    icon: const Icon(Icons.clear),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 10,
                  ),
                  hintText: '検索',
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.horizontal(left: Radius.circular(30), right: Radius.circular(30))
                  )
              ),
              onChanged: (value){
                if(value.isNotEmpty){
                  ref.read(textControllerProvider.notifier).switchState(true);
                }else{
                  ref.watch(textControllerProvider.notifier).switchState(false);
                }
              },
              onFieldSubmitted: (value){
                ref.read(searchResultsProvider.notifier).searchCalendar(value).then((value){
                  ref.read(focusState.notifier).switchState(true);
                  ref.read(resultPage.notifier).resultPage(true);
                });
              },
            ),
          ),
          Consumer(
            builder: (context, ref, _) {
              final focus = ref.watch(focusState);
              if(focus) {
                return TextButton(
                    onPressed: () {
                      ref.read(focusState.notifier).switchState(false);
                      ref.read(resultPage.notifier).resultPage(false);
                      ref.watch(textControllerProvider.notifier).switchState(
                          false);
                      controller.clear();
                      FocusScope.of(context).unfocus();
                    },
                    child: const Text(
                      'キャンセル',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                      ),
                    )
                );
              }else{
                return const SizedBox();
              }
            }
          ),
        ],
    );
  }
}