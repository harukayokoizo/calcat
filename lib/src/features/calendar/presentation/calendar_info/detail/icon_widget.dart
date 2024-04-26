import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../../../domain/calendar.dart';


class CalendarIconWidget extends ConsumerWidget{
  Calendar calendar;
  CalendarIconWidget(this.calendar, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref){
    final double deviceWidth = MediaQuery.of(context).size.width;
    Widget imagePath = FittedBox(fit: BoxFit.cover, child: Image.asset('images/no_image.png'),);
    if(calendar.image != null) {
      imagePath = FittedBox(fit: BoxFit.contain, child: Image.network(calendar.image!),);
    }
    return Stack(
      children: [
        Container(
          height: 250,
          width: deviceWidth,
          clipBehavior: Clip.hardEdge,
          decoration: const BoxDecoration(
            color: Colors.grey,
          ),
          child: imagePath
        ),
        Padding(
          padding: const EdgeInsets.only(top: 0.0),
          child: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
      ],
    );
  }
}