import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
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
    final imagePath = calendar.image ?? '';
    Image noImage = Image.asset('images/no_image.png', fit: BoxFit.cover,);
    CachedNetworkImage imageWidget = CachedNetworkImage(
      imageUrl: imagePath,
      errorWidget: (context, url, error) => Container(color: const Color(0xFFDCDCDC)),
    );

    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: const BoxDecoration(
        color: Colors.grey,
      ),
      child: FittedBox(
          fit: BoxFit.cover,
          child: calendar.image == null ? noImage : imageWidget
      ),
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