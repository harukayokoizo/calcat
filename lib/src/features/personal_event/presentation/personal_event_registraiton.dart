import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_calendar/src/features/personal_event/presentation/repeat_form.dart';

import 'color_form.dart';
import 'date_format.dart';
import 'notification_form.dart';

class PersonalEventRegistration extends StatelessWidget{
  final DateTime focusedDay;
  const PersonalEventRegistration(this.focusedDay, {super.key});

  @override
  Widget build(BuildContext context){
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double deviceHeight = MediaQuery.of(context).size.height;
    final titleController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        titleTextStyle: const TextStyle(
          color: Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        title: const Text('予定作成'),
        centerTitle: true,
      ),
      body: Form(
        child: Column(
          children: [
            Container(
              decoration: const BoxDecoration(
                border: Border(
                    top: BorderSide(color: Colors.grey, width: 1.0),
                    bottom: BorderSide(color: Colors.grey, width: 1.0)
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: TextFormField(
                  controller: titleController,
                  decoration: const InputDecoration(
                    hintText: 'イベント名',
                    border: InputBorder.none
                  ),
                  onChanged: (value){
                    // setState(() {
                    //   mailAddress = value;
                    // });
                  },
                ),
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                border: Border(
                    //top: BorderSide(color: Colors.grey, width: 1.0),
                    bottom: BorderSide(color: Colors.grey, width: 1.0)
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: TextFormField(
                  controller: titleController,
                  decoration: const InputDecoration(
                      hintText: 'イベント内容',
                      border: InputBorder.none
                  ),
                  onChanged: (value){
                    // setState(() {
                    //   mailAddress = value;
                    // });
                  },
                ),
              ),
            ),
            DateSettingFormat(focusedDay),
            const ColorForm(),
            const NotificationForm(),
            const RepeatForm(),
            const Expanded(
              child: SizedBox(),
            ),
            const Padding(
              padding: EdgeInsets.only(bottom: 10.0, right: 20.0),
              child: Align(
                  alignment: Alignment.centerRight,
                  child: SaveEventButton(),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class SaveEventButton extends ConsumerWidget{
  const SaveEventButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref){
    return ElevatedButton(
      onPressed: () async{

      },
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
        //side: BorderSide(color: Colors.black)
      ),
      child: const Text(
        "保存",
        style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold
        ),
      ),
    );
  }
}