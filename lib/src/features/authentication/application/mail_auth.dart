import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../data/fcm_token_repositories.dart';
import '../data/user_repositories.dart';

final authenticateProvider = Provider<MailAuth>(
        (ref) => MailAuth(ref)
);

class MailAuth{
  Ref ref;

  MailAuth(this.ref);

  Future<String> createAccountAndUser(String emailAddress, String password) async{
    try{
      final User user = await createAccount(emailAddress, password);
      final fcmToken = await FirebaseMessaging.instance.getToken();
      await ref.read(userRepositories).createUser(user.uid, fcmToken!);

      String? oldToken = await ref.read(fcmTokenRepositories).operateCollection(user.uid, fcmToken);
      if(oldToken != null && oldToken != fcmToken){
        await ref.read(userRepositories).deleteUserHasOldToken(oldToken);
      }

      return 'success';
    }catch (e){
      signOut();
      return e.toString();
    }
  }

  Future<String> loginAndCreateUser(String emailAddress, String password) async{
    try{
      final User user = await signInAccount(emailAddress, password);
      final fcmToken = await FirebaseMessaging.instance.getToken();

      await ref.read(userRepositories).createUser(user.uid, fcmToken!);

      String? oldToken = await ref.read(fcmTokenRepositories).operateCollection(user.uid, fcmToken);
      if(oldToken != null && oldToken != fcmToken){
        await ref.read(userRepositories).deleteUserHasOldToken(oldToken);
      }

      return 'success';
    }catch (e){
      signOut();
      return e.toString();
    }
  }

  //アカウント作成
  Future<User> createAccount(String emailAddress, String password) async{
    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailAddress,
          password: password
      );

      return userCredential.user!;
    } on FirebaseAuthException catch (e) {
      String error = '';
      if (e.code == 'email-already-in-use') {
        error = '指定されたメールアアドレスを持つアカウントが既に存在しています。';
      } else if (e.code == 'invalid-email') {
        error = 'メールアドレスが有効ではありません。';
      } else if (e.code == 'weak-password'){
        error = 'パスワードが十分に強くありません。';
      }
      throw error;
    }
  }

  //サインイン
  Future<User> signInAccount(String emailAddress, String password) async{
    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailAddress,
          password: password
      );

      return userCredential.user!;
    } on FirebaseAuthException catch (e) {
      String error = 'ログインに失敗しました。';
      throw error;
    }
  }

  //サインアウト
  Future<void> signOut() async{
    await FirebaseAuth.instance.signOut();
  }

  //パスワード再設定
  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      print(e.code);
    }
  }
}