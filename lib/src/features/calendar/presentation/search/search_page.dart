import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_calendar/src/features/calendar/presentation/search/search_form.dart';
import 'package:share_calendar/src/features/calendar/presentation/search/search_list.dart';
import 'package:share_calendar/src/features/calendar/presentation/search/search_results.dart';
import '../../../search_value/data/search_value_repositories.dart';
import '../../../search_value/presentation/search_value_list.dart';
import '../../application/search_provider.dart';
import '../../domain/calendar_document.dart';

class SearchPage extends ConsumerWidget{
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref){
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: SearchForm(),
      ),
      body: Consumer(
        builder: (context, ref, _) {
          final List<CalendarDocument> searchResults = ref.watch(searchResultsProvider);
          final searchPageState = ref.watch(searchPageProvider);
          Widget display = displaySearchPage(searchPageState.result!, searchPageState.editing!, searchResults);
          return GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: (){
              FocusScope.of(context).unfocus();
            },
            child: display
          );
        }
      ),
    );
  }
}

Widget displaySearchPage(bool result, bool textEditing, List<CalendarDocument> searchResults){
  if(result){
    return SearchResults(searchResults);
  }else{
    if(textEditing){
      return SearchCalendarList();
    }else{
      return SearchValueList();
    }
  }
}