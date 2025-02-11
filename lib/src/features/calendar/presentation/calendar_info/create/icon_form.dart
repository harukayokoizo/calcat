import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../../../application/calendar_provider.dart';
import '../../../application/image_provider.dart';
import '../../../domain/calendar.dart';
import 'package:path/path.dart' as p;

class IconForm extends ConsumerWidget{
  Calendar calendar;
  IconForm(this.calendar, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref){
    final double deviceHeight = MediaQuery.of(context).size.height;
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
        child: CachedNetworkImage(
          imageUrl: calendar.image!,
          errorWidget: (context, url, error) => Container(color: const Color(0xFFDCDCDC)),
        ),
      );
    }
    return InkWell(
      onTap: () async{
        final ImagePicker picker = ImagePicker();

        final imageSource = await picker.pickImage(source: ImageSource.gallery);

        // var fileFromImage = File(imageSource!.path);
        // var basename = p.basenameWithoutExtension(fileFromImage.path);
        // var pathString = fileFromImage.path.split(p.basename(fileFromImage.path))[0];
        //
        // var pathStringWithExtension = "$pathString${basename}_image.jpg";
        //
        // final result = await FlutterImageCompress.compressAndGetFile(
        //   imageSource.path,
        //   pathStringWithExtension,
        //   minWidth: 500,
        //   minHeight: 500,
        //   quality: 94,
        // );

        ref.read(imageStateProvider.notifier).saveImageSource(imageSource!);
      },
      child: Container(
        height: deviceHeight / 3.0,
        width: deviceWidth,
        clipBehavior: Clip.hardEdge,
        decoration: const BoxDecoration(
          color: Colors.grey,
        ),
        child: imagePath,
      ),
    );
  }
}