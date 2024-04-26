// User型
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final currentUserProvider = Provider<User?>((ref) => FirebaseAuth.instance.currentUser);

// final currentUser = Provider<User?>((ref) => FirebaseAuth.instance.currentUser);