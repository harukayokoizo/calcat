// チェックがついているものだけ絞り込む
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../common_widgets/application/common_provider.dart';

final authStateChangeProvider = StreamProvider.autoDispose<User?>((ref){
  final firebaseAuth = ref.watch(firebaseAuthProvider);
  return firebaseAuth.authStateChanges();

});

final firebaseAuthProvider = Provider<FirebaseAuth>((ref) => FirebaseAuth.instance);

//final itemListExceptionProvider = StateProvider<CustomException?>((_) => null);

final userControllerProvider = StateNotifierProvider<UserController, AsyncValue<int>>(
        (ref) {
      final user = ref.read(currentUserProvider);
      return UserController(ref, user?.uid);
    }
);

// 非同期でラップ
class UserController extends StateNotifier<AsyncValue<int>> {
  final Ref ref;
  final String? _userId;

  // Readerとnull許可ユーザIDを受け取る
  UserController(this.ref, this._userId) : super(const AsyncValue.loading()) {
    // ログイン中のユーザーがいない場合（または、ユーザーが存在しない場合）、アイテムの取得をする
    if (_userId != null) {
      state = const AsyncValue.data(0);
    }else{
      state = const AsyncValue.data(1);
    }
  }

  void changeTopPage(){
    state = const AsyncValue.data(0);
  }

  void changeLoginPage(){
    state = const AsyncValue.data(1);
  }

//ユーザー情報編集

}