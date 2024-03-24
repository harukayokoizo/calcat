import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../domain/calendar.dart';

class CalendarIconWidget extends ConsumerWidget{
  Calendar calendar;
  CalendarIconWidget(this.calendar, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref){
    Image imagePath = Image.asset('images/no_image.png',fit: BoxFit.cover,);
    if(calendar.image != null) {
      imagePath = Image.network(calendar.image!);
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
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
        )
      ],
    );
  }
}