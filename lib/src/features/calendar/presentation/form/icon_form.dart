import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../../application/calendar_provider.dart';
import '../../application/image_provider.dart';
import '../../domain/calendar.dart';

class IconForm extends ConsumerWidget{
  Calendar? calendar;
  IconForm({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref){
    final state = ref.watch(imageStateProvider);
    Image imagePath = Image.asset('images/no_image.png',fit: BoxFit.cover,);
    if(state != null) {
      imagePath = Image.file(File(state.path));
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            'アイコン',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () async{
                final ImagePicker picker = ImagePicker();

                final imageSource = await picker.pickImage(source: ImageSource.gallery);

                ref.read(imageStateProvider.notifier).saveImageSource(imageSource!);
              },
              child: Container(
                height: 100,
                width: 100,
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey,
                ),
                child: FittedBox(
                    fit: BoxFit.cover,
                    child: imagePath
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}