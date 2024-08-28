import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../application/color_setting_provider.dart';
import '../../../application/notification_setting_provider.dart';
import '../../../domain/event.dart';
import 'color_detail.dart';

class TitleDetail extends ConsumerWidget{
  final Event event;
  const TitleDetail(this.event, {super.key});

  @override

  Widget build(BuildContext context, WidgetRef ref){
    final colors = ref.read(colorList);
    final double deviceWidth = MediaQuery.of(context).size.width;
    final color = getColor(colors, event.color!);

    return Padding(
      padding: const EdgeInsets.only(top: 50.0, bottom: 10.0),
      child: SizedBox(
        width: deviceWidth,
        child: Center(
          child: Text(
            event.title!,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: color
            ),
          ),
        ),
      ),
    );
    return Container(
      width: deviceWidth,
      decoration: const BoxDecoration(
        border: Border(
            top: BorderSide(color: Colors.grey, width: 1.0),
            bottom: BorderSide(color: Colors.grey, width: 1.0)
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Text(
          event.title!,
          style: const TextStyle(
              fontSize: 18
          ),
        ),
      ),
    );
  }
}