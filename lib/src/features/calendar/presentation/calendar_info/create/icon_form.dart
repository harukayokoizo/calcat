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
    Widget imagePath = FittedBox(fit: BoxFit.cover, child: Image.asset('images/no_image.png'),);
    if(state != null) {
      imagePath = FittedBox(
        fit: BoxFit.cover,
        child: Image.file(
          File(state.path),
          errorBuilder:(c,o,s) {
            return Container(color: Colors.grey);
          },
        ),
      );
    }else if(calendar.image != null){
      imagePath = FittedBox(
        fit: BoxFit.cover,
        child: Image.network(
          calendar.image!,
          errorBuilder:(c,o,s) {
            return Container(color: Colors.grey);
          },
        ),
      );
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
        child: imagePath
      ),
    );
  }
}