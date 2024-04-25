import 'dart:io';
import 'dart:async';
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
  Future<String> uploadFile() async{
    final storage = FirebaseStorage.instance;

    Reference reference = storage.ref().child('images/calendar').child(state!.name); //保存するフォルダ
    await reference.putFile(File(state!.path));

    var imageUrl = await reference.getDownloadURL();

    return imageUrl;
  }

}