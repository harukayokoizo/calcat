import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

import '../../search_value/domain/search_value.dart';
import '../../tab_value/domain/tab_value.dart';
import '../domain/fcm_token.dart';


final fcmTokenRepositories = Provider((ref) => FcmTokenRepositories());

class FcmTokenRepositories {
  Isar? isar;

  Future<void> connectIsar() async{
    final dir = await getApplicationDocumentsDirectory();
    if (Isar.instanceNames.isNotEmpty) {
      // 既存のインスタンスを取得
      isar = Isar.getInstance('myInstance');
    }else {
      isar ??= await Isar.open(
        [FcmTokenSchema, SearchValueSchema, TabValueSchema],
        directory: dir.path,
        name: 'myInstance',
      );
    }
  }

  Future<String?> operateCollection(String uid, String fcmToken) async{
    try {
      String? token;
      if (isar == null) {
        await connectIsar();
      }
      final fcmTokenCollection = await getFcmToken(uid);
      if (fcmTokenCollection == null) {
        await createCollection(uid, fcmToken);
      } else {
        token = fcmTokenCollection.fcmToken;
        await updateCollection(fcmTokenCollection, fcmToken);
      }

      return token;
    }catch (e){
      throw e.toString();
    }
  }

  Future<void> createCollection(String uid, String value) async{
    try {
      DateTime date = DateTime.now();
      final fcmToken = FcmToken()
        ..fcmToken = value
        ..uid = uid
        ..created = date;

      await isar!.writeTxn(() async {
        await isar!.fcmTokens.put(fcmToken);
      });
    }catch (e){
      throw 'トークンの作成に失敗しました。';
    }
  }

  Future<void> updateCollection(FcmToken fcmTokenCollection, String value) async{
    try {
      DateTime date = DateTime.now();
      await isar!.writeTxn(() async {
        fcmTokenCollection.fcmToken = value;
        fcmTokenCollection.created = date;
        await isar!.fcmTokens.put(fcmTokenCollection);
      });
    }catch (e){
      throw 'トークンの更新に失敗しました。';
    }
  }

  Future<FcmToken?> getFcmToken(String uid) async{
    try {
      final fcmTokenCollection = await isar!.fcmTokens.filter()
          .uidEqualTo(uid)
          .findFirst();

      return fcmTokenCollection;
    }catch (e){
      print(e.toString());
      throw 'トークンの取得に失敗しました。';
    }
  }
  


}