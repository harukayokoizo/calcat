import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../../../application/calendar_provider.dart';
import '../../../application/image_provider.dart';
import '../../../domain/calendar.dart';

class IconForm extends ConsumerWidget{
  Calendar calendar;
  IconForm(this.calendar, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref){
    final double deviceWidth = MediaQuery.of(context).size.width;
    final state = ref.watch(imageStateProvider);
    Image imagePath = Image.asset('images/no_image.png',fit: BoxFit.cover,);
    if(state != null) {
      imagePath = Image.file(File(state.path));
    }else if(calendar.image != null){
      imagePath = Image.network(calendar.image!);
    }
    return InkWell(
      onTap: () async{
        final ImagePicker picker = ImagePicker();

        final imageSource = await picker.pickImage(source: ImageSource.gallery);

        ref.read(imageStateProvider.notifier).saveImageSource(imageSource!);
      },
      child: Container(
        height: 200,
        width: deviceWidth,
        clipBehavior: Clip.hardEdge,
        decoration: const BoxDecoration(
          color: Colors.grey,
        ),
        child: FittedBox(
            fit: BoxFit.contain,
            child: imagePath
        ),
      ),
    );
  }
}