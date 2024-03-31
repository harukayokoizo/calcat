import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/search_value_repositories.dart';

final searchValueListProvider = FutureProvider<List<String?>>(
        (ref) {
          final searchValueList = ref.read(searchValueRepositories).getSearchValue();
          return searchValueList;
    });