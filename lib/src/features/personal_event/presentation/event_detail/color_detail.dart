import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../application/color_setting_provider.dart';
import '../../domain/event.dart';

class EventColorDetail extends ConsumerWidget{
  Event personalEvent;
  EventColorDetail(this.personalEvent, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref){
    final colors = ref.read(colorList);
    final double deviceWidth = MediaQuery.of(context).size.width;

    return Container(
      width: deviceWidth,
      decoration: const BoxDecoration(
        border: Border(
            bottom: BorderSide(color: Colors.grey, width: 1.0)
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Row(
          children: [
            const Icon(Icons.color_lens_outlined),
            const Padding(
              padding: EdgeInsets.only(left: 4.0),
              child: Text(
                '色',
                style: TextStyle(
                  fontSize: 18,
                  //fontWeight: FontWeight.bold
                ),
              ),
            ),
            const Expanded(child: SizedBox()),
            Container(
              height: 20,
              width: 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color(colors[personalEvent.color!]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}