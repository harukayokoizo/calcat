import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/search_value_repositories.dart';

final searchValueListProvider = FutureProvider.autoDispose<List<String?>>(
        (ref) async{
          List<String?> searchValueList = await ref.read(searchValueRepositories).getSearchValue();
          return searchValueList;
    });

final searchValue = StateNotifierProvider.autoDispose<SearchValueState, String?>(
        (ref) => SearchValueState()
);

class SearchValueState extends StateNotifier<String?>{
  SearchValueState() : super(null);

  void tapSearchValue(String? value){
    state = value;
  }
}