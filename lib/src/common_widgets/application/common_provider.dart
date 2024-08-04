// User型
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';

final currentUserProvider = Provider.autoDispose<User?>((ref) => FirebaseAuth.instance.currentUser);

// StateProvider を使って PackageInfo を管理する
final packageInfoProvider = StateProvider<PackageInfo?>((ref){
  return null;
});

// final currentUser = Provider<User?>((ref) => FirebaseAuth.instance.currentUser);