import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final pushNotification = Provider((ref) => PushNotification());

class PushNotification{
  dynamic fcmToken;
  PushNotification(){
    getToken();
  }

  Future<dynamic> getToken() async{
    fcmToken = await FirebaseMessaging.instance.getToken();
  }

  void updateToken(){
    FirebaseMessaging.instance.onTokenRefresh
        .listen((fcmToken) {})
        .onError((err) {});
  }
}