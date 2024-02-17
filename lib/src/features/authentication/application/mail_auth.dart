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
  Future<User?> signInAccount(String emailAddress, String password) async{
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailAddress,
          password: password
      );
      print(credential);
      return credential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
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