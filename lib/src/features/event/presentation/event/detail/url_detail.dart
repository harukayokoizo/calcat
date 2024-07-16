import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../application/notification_setting_provider.dart';
import '../../../domain/event.dart';

class UrlDetail extends StatelessWidget{
  Event event;
  UrlDetail(this.event, {super.key});

  @override

  Widget build(BuildContext context){
    final Uri url = Uri.parse(event.url!);
    final double deviceWidth = MediaQuery.of(context).size.width;

    return Container(
      width: deviceWidth,
      decoration: const BoxDecoration(
        border: Border(
            bottom: BorderSide(color: Colors.grey, width: 1.0)
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: GestureDetector(
          onTap: () async{
            if(await canLaunchUrl(url)){
              await launchUrl(url);
            }else{
              print('Could not Launch');
            }
          },
          child: Text(
            event.url!,
            style: const TextStyle(
              fontSize: 18,
              color: Colors.blue,
            ),
          ),
        ),
      ),
    );
  }
}