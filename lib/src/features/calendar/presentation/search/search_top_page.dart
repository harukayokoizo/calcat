import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_calendar/src/features/calendar/presentation/search/search_form.dart';
import '../../../search_value/data/search_value_repositories.dart';
import '../../application/search_provider.dart';
import 'follow_ranking_list.dart';
import 'limited_search_page.dart';

class SearchTopPage extends ConsumerWidget{
  const SearchTopPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref){
    ref.read(searchValueRepositories).connectIsar();
    return Scaffold(
      appBar: AppBar(
        title: SearchFormDisplay(),
      ),
      body: FollowRankingList(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue.shade500,
        shape: const CircleBorder(),
        heroTag: "search",
        child: const Icon(Icons.search, color: Colors.white),
        onPressed: () async {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const LimitedCalendar(),
            ),
          );
        },
      ),
    );
  }
}