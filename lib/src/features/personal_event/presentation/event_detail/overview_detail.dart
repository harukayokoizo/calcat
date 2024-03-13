import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../application/notification_setting_provider.dart';
import '../../domain/personal_event.dart';

class OverViewDetail extends StatelessWidget{
  PersonalEvent event;
  OverViewDetail(this.event, {super.key});

  @override

  Widget build(BuildContext context){
    final double deviceWidth = MediaQuery.of(context).size.width;

    return Container(
      width: deviceWidth,
      decoration: const BoxDecoration(
        border: Border(
          //top: BorderSide(color: Colors.grey, width: 1.0),
            bottom: BorderSide(color: Colors.grey, width: 1.0)
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Text(
          event.event!,
          style: const TextStyle(
              fontSize: 18
          ),
        ),
      ),
    );
  }
}