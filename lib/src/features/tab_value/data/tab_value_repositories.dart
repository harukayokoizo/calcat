import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

import '../../authentication/domain/fcm_token.dart';
import '../../event/domain/local_event.dart';
import '../../search_value/domain/search_value.dart';
import '../domain/tab_value.dart';

final tabValueRepositories = Provider((ref) => TabValueRepositories());

class TabValueRepositories {
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
      print('connect');
      throw e.toString();
    }
  }

  Future<TabValue?> controlTabValue() async{
    try {
      await connectIsar();
      TabValue? tabValue = await getTabValue();
      tabValue ??= await createCollection();
      return tabValue;
    }catch (e){
      throw e.toString();
    }
  }

  Future<TabValue> createCollection() async{
    try {
      final tabValue = TabValue()
        ..tabIndex = 0
        ..listTabIndex = 0;

      await isar!.writeTxn(() async {
        await isar!.tabValues.put(tabValue);
      });
      return tabValue;
    }catch (e){
      throw e.toString();
    }
  }

  Future<void> updateTabIndex(TabValue tabLogCollection, int index) async{
    await isar!.writeTxn(() async {
      tabLogCollection.tabIndex = index;
      await isar!.tabValues.put(tabLogCollection);
    });
  }

  Future<void> updateListTabIndex(TabValue tabLogCollection, int index) async{
    await isar!.writeTxn(() async {
      tabLogCollection.listTabIndex = index;
      await isar!.tabValues.put(tabLogCollection);
    });
  }

  Future<TabValue?> getTabValue() async{
    try {
      final tabLog = await isar?.tabValues.where().findFirst();

      return tabLog;
    }catch (e){
      print('get');
      throw e.toString();
    }
  }
}