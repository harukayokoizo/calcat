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

    return Padding(
      padding: const EdgeInsets.only(top: 30.0, left: 20, right: 10.0),
      child: SizedBox(
        width: deviceWidth,
        child: GestureDetector(
          onTap: () async{
            if(await canLaunchUrl(url)){
              await launchUrl(url);
            }else{
              print('Could not Launch');
            }
          },
          child: RichText(
            text: TextSpan(
              style: const TextStyle(color: Colors.black),
              children: [
                const TextSpan(
                  text: 'URL：',
                  style: TextStyle(fontSize: 18),
                ),
                TextSpan(
                  text: event.url!,
                  style: const TextStyle(color: Colors.blue, fontSize: 18),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}