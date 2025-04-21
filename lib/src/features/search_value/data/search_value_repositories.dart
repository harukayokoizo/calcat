import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

import '../../authentication/domain/fcm_token.dart';
import '../../event/domain/local_event.dart';
import '../../tab_value/domain/tab_value.dart';
import '../domain/search_value.dart';

final searchValueRepositories = Provider((ref) => SearchValueRepositories());

class SearchValueRepositories {
  Isar? isar;

  Future<void> connectIsar() async{
    try {
      final dir = await getApplicationDocumentsDirectory();
      if (Isar.instanceNames.isNotEmpty) {
        // 既存のインスタンスを取得
        isar = Isar.getInstance('myInstance');
      } else {
        isar ??= await Isar.open(
          [FcmTokenSchema, SearchValueSchema, TabValueSchema, LocalEventSchema],
          directory: dir.path,
          name: 'myInstance',
        );
      }
    }catch (e){
      print(e.toString());
      throw e.toString();
    }
  }

  Future<void> operateCollection(String value) async{
    await connectIsar();
    print(isar);
    final searchCollection = await getSingleSearchValue(value);
    if(searchCollection != null){
      await updateSearchValue(searchCollection);
    }else{
      await createCollection(value);
    }

    await deleteSearchValue();
  }

  Future<void> createCollection(String value) async{
    DateTime date = DateTime.now();
    final searchValue = SearchValue()
      ..searchValue = value
      ..created = date;

    await isar!.writeTxn(() async {
      await isar!.searchValues.put(searchValue);
    });
  }

  Future<void> updateSearchValue(SearchValue searchCollection) async{
    DateTime date = DateTime.now();
    await isar!.writeTxn(() async {
      searchCollection.created = date;
      await isar!.searchValues.put(searchCollection);
    });
  }

  Future<SearchValue?> getSingleSearchValue(String value) async{
    final searchValue = await isar!.searchValues.filter()
        .searchValueEqualTo(value)
        .findFirst();

    return searchValue;
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

  Future<void> deleteSearchValue() async{
    int count = await isar!.searchValues.count();
    if(count > 20){
      final id = await isar!.searchValues
          .where(sort: Sort.asc)
          .anyCreated()
          .idProperty()
          .findFirst();

      await isar!.writeTxn(() async {
        await isar!.searchValues.delete(id!);
      });
    }
  }

  Future<void> deleteSingleSearchValue(String searchValue) async{
    final id = await isar!.searchValues
        .filter()
        .searchValueEqualTo(searchValue)
        .idProperty()
        .findFirst();

    await isar!.writeTxn(() async {
      await isar!.searchValues.delete(id!);
    });
  }
}