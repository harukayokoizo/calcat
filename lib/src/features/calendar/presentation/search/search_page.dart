import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_calendar/src/features/calendar/presentation/search/search_form.dart';

import '../../application/search_provider.dart';

class SearchPage extends ConsumerWidget{
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref){
    final bool search = ref.watch(searchSwitch);
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
            SearchForm(search)
          ],
        ),
      ),
    );
  }
}