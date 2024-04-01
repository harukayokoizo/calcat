import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

import '../domain/search_value.dart';

final searchValueRepositories = Provider((ref) => SearchValueRepositories());

class SearchValueRepositories {
  Isar? isar;

  Future<void> connectIsar() async{
    final dir = await getApplicationDocumentsDirectory();
    isar ??= await Isar.open(
      [SearchValueSchema],
      directory: dir.path,
    );
  }

  Future<void> createCollection(String value) async{
    if(isar == null) {
      await connectIsar();
    }
    DateTime date = DateTime.now();
    final searchValue = SearchValue()
      ..searchValue = value
      ..created = date;

    await isar!.writeTxn(() async {
      await isar!.searchValues.put(searchValue);
    });
  }

  Future<List<String?>> getSearchValue() async{
    if(isar == null) {
      await connectIsar();
    }
    final searchValue = await isar!.searchValues
        .where(sort: Sort.desc)
        .anyCreated()
        .limit(20)
        .searchValueProperty()
        .findAll();

    return searchValue;
  }
}