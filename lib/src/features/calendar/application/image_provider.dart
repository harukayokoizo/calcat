import 'dart:io';
import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

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

  // Future<void> getImage() async{
  //   final ImagePicker picker = ImagePicker();
  //
  //   final imageSource = await picker.pickImage(source: ImageSource.gallery);
  //
  //   state = imageSource;
  // }

}