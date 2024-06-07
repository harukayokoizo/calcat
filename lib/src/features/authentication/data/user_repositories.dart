import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userRepositories = Provider((ref) => UserRepositories(ref));

class UserRepositories{
  Ref ref;
  UserRepositories(this.ref);

  Future<void> createUser(String mailAddress, String uid) async{
    try {
      final DateTime date = DateTime.now();
      await FirebaseFirestore.instance
          .collection('user')
          .doc(uid)
          .set(
          {
            'timestamp': date,
            'mailAddress': mailAddress,
          });
    }catch (e){
      throw 'ログインに失敗しました。';
    }
  }

  Future<String?> getUser(String mailAddress) async{
    final user = await FirebaseFirestore.instance
        .collection('user')
        .where('mailAddress', isEqualTo: mailAddress)
        .get();

    if(user.docs.isNotEmpty){
      return user.docs.first.id;
    }

    return null;
  }
}