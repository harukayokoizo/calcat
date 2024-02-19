import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';

final authenticateProvider = Provider<MailAuth>(
        (ref) => MailAuth()
);

class MailAuth{

  //アカウント作成
  Future<String> createAccount(String emailAddress, String password) async{
    String error = '';
    try {
      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailAddress,
          password: password
      );
      return 'success';
      //ref.read(currentUserController.notifier).checkSignInState();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        error = '指定されたメールアアドレスを持つアカウントが既に存在しています。';
      } else if (e.code == 'invalid-email') {
        error = 'メールアドレスが有効ではありません。';
      } else if (e.code == 'weak-password'){
        error = 'パスワードが十分に強くありません。';
      }
      return error;
    }
  }

  //サインイン
  Future<String> signInAccount(String emailAddress, String password) async{
    String error = '';
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailAddress,
          password: password
      );
      return 'success';
    } on FirebaseAuthException catch (e) {
      error = 'ログインに失敗しました。';
      return error;
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