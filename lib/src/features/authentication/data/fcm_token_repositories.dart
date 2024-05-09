import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

import '../domain/fcm_token.dart';


final fcmTokenRepositories = Provider((ref) => FcmTokenRepositories());

class FcmTokenRepositories {
  Isar? isar;

  Future<void> connectIsar() async{
    final dir = await getApplicationDocumentsDirectory();
    isar ??= await Isar.open(
      [FcmTokenSchema],
      directory: dir.path,
    );
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
        await updateCollection(fcmTokenCollection, fcmToken);
        token = fcmTokenCollection.fcmToken;
      }

      return token;
    }catch (e){
      throw 'トークンの保存に失敗しました。';
    }
  }

  Future<void> createCollection(String uid, String value) async{
    DateTime date = DateTime.now();
    final fcmToken = FcmToken()
      ..fcmToken = value
      ..uid = uid
      ..created = date;

    await isar!.writeTxn(() async {
      await isar!.fcmTokens.put(fcmToken);
    });
  }

  Future<void> updateCollection(FcmToken fcmTokenCollection, String value) async{
    DateTime date = DateTime.now();
    await isar!.writeTxn(() async {
      fcmTokenCollection.fcmToken = value;
      fcmTokenCollection.created = date;
      await isar!.fcmTokens.put(fcmTokenCollection);
    });
  }

  Future<FcmToken?> getFcmToken(String uid) async{
    final fcmTokenCollection = await isar!.fcmTokens.filter().uidEqualTo(uid).findFirst();

    return fcmTokenCollection;
  }
  


}