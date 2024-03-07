import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../domain/personal_event.dart';
import 'notification_settings_page.dart';

class NotificationForm extends StatelessWidget{
  PersonalEvent? event;
  NotificationForm(this.event, {super.key});

  @override

  Widget build(BuildContext context){
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double deviceHeight = MediaQuery.of(context).size.height;
    return InkWell(
      onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => NotificationSettingsPage(event),
          ),
        );
      },
      child: Container(
        width: deviceWidth,
        decoration: const BoxDecoration(
          border: Border(
              bottom: BorderSide(color: Colors.grey, width: 1.0)
          ),
        ),
        child: const Padding(
          padding: EdgeInsets.all(10.0),
          child: Row(
            children: [
              Icon(Icons.notifications_none),
              Padding(
                padding: EdgeInsets.only(left: 4.0),
                child: Text(
                  '通知',
                  style: TextStyle(
                    fontSize: 18,
                    //fontWeight: FontWeight.bold
                  ),
                ),
              ),
              Expanded(
                child: SizedBox(),
              ),
              Icon(Icons.arrow_forward_ios)
            ],
          ),
        ),
      ),
    );
  }
}