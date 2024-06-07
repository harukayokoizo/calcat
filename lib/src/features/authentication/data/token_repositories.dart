import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../common_widgets/application/common_provider.dart';
import '../../notification/application/push_notification.dart';
import 'fcm_token_repositories.dart';

final tokenRepositories = Provider((ref) => TokenRepositories(ref));

class TokenRepositories{
  Ref ref;
  TokenRepositories(this.ref);

  Future<void> controlUser(String fcmToken) async{
    try {
      final user = ref.read(currentUserProvider);
      if(user != null) {
        await createUser(user.uid, fcmToken);
        String? oldToken = await ref.read(fcmTokenRepositories).operateCollection(user.uid, fcmToken);
        if(oldToken != null && oldToken != fcmToken){
          await deleteUserHasOldToken(oldToken);
        }
      }
    }catch (e){
      print(e);
    }
  }

  Future<void> createUser(String uid, String fcmToken) async{
    try {
      final DateTime date = DateTime.now();
      await FirebaseFirestore.instance
          .collection('token')
          .add(
          {
            'token': fcmToken,
            'timestamp': date,
            'uid': uid,
          });
    }catch (e){
      throw 'ログインに失敗しました。';
    }
  }

  Future<bool> getUser(String uid, String fcmToken) async{
    final userDoc = await FirebaseFirestore.instance
        .collection('token')
        .where('uid', isEqualTo: uid)
        .where('token', isEqualTo: fcmToken)
        .get();

    return userDoc.docs.isEmpty;
  }

  Future<String?> deleteUser() async{
    try {
      final user = ref.read(currentUserProvider);
      final fcmToken = await FirebaseMessaging.instance.getToken();
      final deviceToken = await FirebaseFirestore.instance
          .collection('token')
          .where('uid', isEqualTo: user!.uid)
          .where('token', isEqualTo: fcmToken)
          .get();

      if (deviceToken.docs.isNotEmpty) {
        for (var doc in deviceToken.docs) {
          await doc.reference.delete();
        }
      }
      return null;
    }catch (e){
      return 'ログアウトに失敗しました。';
    }
  }

  Future<void> deleteUserHasOldToken(String fcmToken) async{
    try {
      final user = ref.read(currentUserProvider);
      final deviceToken = await FirebaseFirestore.instance
          .collection('token')
          .where('uid', isEqualTo: user!.uid)
          .where('token', isEqualTo: fcmToken)
          .get();

      if (deviceToken.docs.isNotEmpty) {
        for (var doc in deviceToken.docs) {
          await doc.reference.delete();
        }
      }
    }catch (e){
      throw '古いトークンを削除できませんでした。';
    }
  }
}