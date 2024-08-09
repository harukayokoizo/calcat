import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_calendar/src/features/calendar/presentation/search/search_page.dart';

import '../../../search_value/application/search_value_list_provider.dart';
import '../../../search_value/data/search_value_repositories.dart';
import '../../application/search_provider.dart';

class SearchForm extends ConsumerWidget{
  final TextEditingController controller = TextEditingController();

  SearchForm({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref){
    final selectedText = ref.watch(searchPageProvider.select((searchState) => searchState.selectedText));
    if(selectedText != null && selectedText.isNotEmpty){
      controller.text = selectedText;
    }
    return Row(
        children: [
          Expanded(
            child: TextFormField(
              autofocus: true,
              controller: controller,
              decoration: InputDecoration(
                fillColor: Color(0xFFE5E5E5),
                  filled: true,
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: IconButton(
                    onPressed: (){
                      final searchState = ref.read(searchPageProvider);
                      controller.clear();
                      ref.read(searchPageProvider.notifier).saveState(searchState.copyWith(editing: false, text: null));
                    },
                    icon: const Icon(Icons.clear),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 10,
                  ),
                  hintText: '検索',
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.horizontal(left: Radius.circular(30), right: Radius.circular(30)),
                    borderSide: BorderSide.none
                  )
              ),
              onChanged: (value){
                final searchState = ref.read(searchPageProvider);
                if(value.isNotEmpty){
                  ref.read(searchPageProvider.notifier).saveState(searchState.copyWith(editing: true, text: value));
                }else{
                  ref.read(searchPageProvider.notifier).saveState(searchState.copyWith(editing: false));
                }
              },
              onFieldSubmitted: (value){
                if(value.isNotEmpty) {
                  final searchState = ref.read(searchPageProvider);
                  ref.read(searchResultsProvider.notifier).searchCalendar(value).then((value) {
                    ref.read(searchPageProvider.notifier).saveState(searchState.copyWith(result: true));
                  });
                }
              },
            ),
          ),
          TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                'キャンセル',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                ),
              )
          )
        ],
    );
  }
}

class SearchFormDisplay extends ConsumerWidget{
  final TextEditingController controller = TextEditingController();

  SearchFormDisplay({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref){
    return GestureDetector(
      onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SearchPage(),
          ),
        );
      },
      child: TextFormField(
        enabled: false,
        controller: controller,
        decoration: const InputDecoration(
            fillColor: Color(0xFFE5E5E5),
            filled: true,
            prefixIcon: Icon(Icons.search),
            contentPadding: EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 10,
            ),
            hintText: '検索',
            border: OutlineInputBorder(
                borderRadius: BorderRadius.horizontal(left: Radius.circular(30), right: Radius.circular(30)),
                borderSide: BorderSide.none
            )
        ),
      ),
    );
  }
}