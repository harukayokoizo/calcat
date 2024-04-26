import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../common_widgets/application/common_provider.dart';
import '../../notification/application/push_notification.dart';

final userRepositories = Provider((ref) => UserRepositories(ref));

class UserRepositories{
  Ref ref;
  UserRepositories(this.ref);

  Future<void> controlUser() async{
    final user = ref.read(currentUserProvider);
    bool exits = await getUser(user!.uid);
    if(!exits){
      final fcmToken = ref.read(pushNotification).fcmToken;
      createUser(fcmToken, user.uid);
    }
  }

  Future<void> createUser(dynamic fcmToken, String uid) async{
    DateTime date = DateTime.now();
    await FirebaseFirestore.instance
        .collection('user')
        .doc(uid)
        .set(
        {
          'token': fcmToken,
          'timestamp': date,
        });
  }

  Future<bool> getUser(String uid) async{
    final userDoc = await FirebaseFirestore.instance
        .collection('user')
        .doc(uid)
        .get();

    return userDoc.exists;
  }
}