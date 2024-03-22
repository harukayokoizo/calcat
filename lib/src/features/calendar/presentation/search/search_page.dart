import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_calendar/src/features/calendar/presentation/search/search_form.dart';
import 'package:share_calendar/src/features/calendar/presentation/search/search_results.dart';
import 'package:share_calendar/src/features/calendar/presentation/search/selected_calendar.dart';

import '../../application/search_provider.dart';
import '../../domain/calendar_document.dart';

// class SearchPageController extends ConsumerWidget{
//   const SearchPageController({super.key});
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref){
//     final selected = ref.watch(selectedCalendarProvider);
//     if(selected != null){
//       return SelectedCalendar(selected);
//     }else{
//       return const SearchPage();
//     }
//   }
// }

class SearchPage extends ConsumerWidget{
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref){
    final List<CalendarDocument> searchResults = ref.watch(searchResultsProvider);
    final bool search = ref.watch(searchSwitch);
    final bool result = ref.watch(resultPage);
    return Scaffold(
      //appBar: AppBar(),
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: (){
          FocusScope.of(context).unfocus();
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SearchForm(search),
            if(result)
              SearchResults(searchResults),
          ],
        ),
      ),
    );
  }
}