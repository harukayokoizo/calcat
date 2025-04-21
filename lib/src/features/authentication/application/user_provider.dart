// チェックがついているものだけ絞り込む
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../common_widgets/application/common_provider.dart';

final authStateChangeProvider = StreamProvider.autoDispose<User?>((ref){
  final firebaseAuth = ref.watch(firebaseAuthProvider);
  return firebaseAuth.authStateChanges();

});

final firebaseAuthProvider = Provider<FirebaseAuth>((ref) => FirebaseAuth.instance);

final firstAuthentication = StateProvider<bool>((ref) => false);