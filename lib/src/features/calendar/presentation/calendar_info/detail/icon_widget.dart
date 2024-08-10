import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../../../domain/calendar.dart';


class CalendarIconWidget extends ConsumerWidget{
  final Calendar calendar;
  const CalendarIconWidget(this.calendar, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref){
    Widget imagePath = FittedBox(
      fit: BoxFit.cover,
      child: Image.asset('images/no_image.png',),
    );
    if(calendar.image != null) {
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
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: const BoxDecoration(
        color: Colors.grey,
      ),
      child: imagePath
    );
  }
}

class CircularIcon extends StatelessWidget {
  final IconData icon;
  final Color backgroundColor;
  final Color iconColor;
  final double size;

  const CircularIcon({
    required this.icon,
    required this.backgroundColor,
    required this.iconColor,
    this.size = 24.0,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: backgroundColor,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Icon(
          icon,
          color: iconColor,
          size: size * 0.6, // アイコンのサイズを背景に対して調整
        ),
      ),
    );
  }
}