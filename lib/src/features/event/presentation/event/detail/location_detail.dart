import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../application/notification_setting_provider.dart';
import '../../../domain/event.dart';

class LocationDetail extends StatelessWidget{
  final Event event;
  const LocationDetail(this.event, {super.key});

  @override

  Widget build(BuildContext context){
    final location = event.location!;
    final googleMapAppUrl = Uri.parse('comgooglemaps://q=$location');
    final appleMapAppUrl   = Uri.parse('https://maps.apple.com/?q=$location');
    final double deviceWidth = MediaQuery.of(context).size.width;

    return Container(
      width: deviceWidth,
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(color: Color(0xFFA7AFAF), width: 0.1),
          bottom: BorderSide(color: Color(0xFFA7AFAF), width: 0.2),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 12.0, bottom: 12.0, right: 8.0, left: 8.0),
        child: GestureDetector(
          onTap: () async{
            if (await canLaunchUrl(googleMapAppUrl)) { // GoogleMapアプリは立ち上げられるか
              // GoogleMapアプリを立ち上げる
              await launchUrl(googleMapAppUrl);
            } else if (await canLaunchUrl(appleMapAppUrl)) { // iOSの地図アプリは立ち上げられるか
              // iOSの地図アプリを立ち上げる
              await launchUrl(appleMapAppUrl);
            } else {
              throw 'Could not launch url';
            }
          },
          child: RichText(
            text: TextSpan(
              style: const TextStyle(color: Colors.black),
              children: [
                const TextSpan(
                  text: '場所：',
                  style: TextStyle(fontSize: 16),
                ),
                TextSpan(
                  text: event.location!,
                  style: const TextStyle(color: Colors.blue, fontSize: 16),
                ),
              ],
            ),
          ),
          // Text(
          //   event.location!,
          //   style: const TextStyle(
          //     fontSize: 18,
          //     color: Colors.blue,
          //   ),
          // ),
        ),
      ),
    );
  }
}