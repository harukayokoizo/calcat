import 'dart:io';
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

final imageStateProvider = StateNotifierProvider.autoDispose<ImageState, XFile?>(
        (ref){
          return ImageState();
        }
        );

class ImageState extends StateNotifier<XFile?>{
  ImageState() : super(null);

  void saveImageSource(XFile imageSource){
    state = imageSource;
  }

  //FireStorageに画像を保存する。
  Future<void> uploadFile(String calendarId) async{
    final storageRef = FirebaseStorage.instance.ref();

    if(state != null){
      Reference reference = storageRef.child('images/calendar/$calendarId').child(state!.name); //保存するフォルダ
      await reference.putFile(File(state!.path));
    }
  }

}