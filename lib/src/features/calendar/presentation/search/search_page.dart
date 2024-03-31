import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_calendar/src/features/calendar/presentation/search/search_form.dart';
import 'package:share_calendar/src/features/calendar/presentation/search/search_results.dart';
import '../../application/search_provider.dart';
import '../../domain/calendar_document.dart';
import 'limited_calendar_search_page.dart';

class SearchPage extends ConsumerWidget{
  final TextEditingController _controller = TextEditingController();
  SearchPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref){
    return Focus(
      onFocusChange: (value){
        if(value){
          ref.read(focusState.notifier).switchState(value);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: SearchForm(),
        ),
        body: Consumer(
          builder: (context, ref, _) {
            final List<CalendarDocument> searchResults = ref.watch(searchResultsProvider);
            final bool focus = ref.watch(focusState);
            final bool result = ref.watch(resultPage);
            final bool textEditing = ref.watch(textControllerProvider);
            Widget display = displaySearchPage(focus, result, textEditing, searchResults);
            return GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: (){
                FocusScope.of(context).unfocus();
              },
              child: display
            );
          }
        ),
        floatingActionButton: FloatingActionButton(
          heroTag: "search",
          child: const Icon(Icons.search),
          onPressed: () async {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const LimitedCalendar(),
              ),
            );
          },
        ),
      ),
    );
  }
}

Widget displaySearchPage(bool focus, bool result, bool textEditing, List<CalendarDocument> searchResults){
  if(result){
    return SearchResults(searchResults);
  }else{
    if(focus){
      if(textEditing){
        return Container(width: 30, height:30, color: Colors.red,);
      }else{
        return Container(width: 30, height:30,color: Colors.green,);
      }
    }else {
      return Container(width: 30, height:30,color: Colors.blue,);
    }
  }
}