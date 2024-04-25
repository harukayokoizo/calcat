import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../application/event_provider.dart';
import '../../../application/repeat_setting_provider.dart';
import '../../../domain/event.dart';

class RepeatSettingsPage extends ConsumerWidget{
  Event event;
  RepeatSettingsPage(this.event, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref){
    final personalEvent = ref.read(eventFormStateProvider(event));
    final endDate = ref.watch(repeatEndDate(event));
    final repeat = ref.read(repeatList);
    final check = ref.watch(repeatCheck(event));
    return Scaffold(
      appBar: AppBar(
        elevation: 5,
        title: const Text('繰り返し設定'),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () {
              ref.read(eventFormStateProvider(event).notifier).changeRepeatEndDate(endDate);
              ref.read(eventFormStateProvider(event).notifier).changeRepeat(check);
              Navigator.of(context).pop();
            },
            child: const Padding(
              padding: EdgeInsets.only(right: 16.0),
              child: Text(
                "保存",
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.blue,
                    fontWeight: FontWeight.w700
                ),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 10.0, left: 8.0, bottom: 10.0),
            child: Text(
              '頻度',
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20
              ),
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            itemCount: 3,
            itemBuilder: (BuildContext context, int index){
              int value = index == check ? 1 : 0;
              return Container(
                //height: 60,
                decoration: BoxDecoration(
                  border: Border(
                      top: index == 0 ? const BorderSide(color: Colors.grey, width: 1.0) : BorderSide.none,
                      bottom: const BorderSide(color: Colors.grey, width: 1.0)
                  ),
                ),
                child: RadioListTile(
                  title: Text(
                    repeat[index],
                    style: const TextStyle(
                      fontSize: 16,
                      //fontWeight: FontWeight.bold
                    ),
                  ),
                  value: value,
                  groupValue: 1,
                  controlAffinity: ListTileControlAffinity.trailing,
                  //contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16.0),
                  onChanged: (value) {
                    ref.read(repeatCheck(event).notifier).state = index;
                  },
                ),
              );
            }
          ),
          const Padding(
            padding: EdgeInsets.only(top:20.0, left: 8.0),
            child: Text(
              '終了日',
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Align(
              alignment: Alignment.center,
              child: TextButton(
                onPressed: () {
                  showDatePicker(
                      initialDate: personalEvent.from!.add(const Duration(days: 7)),
                      firstDate: personalEvent.from!,
                      lastDate: DateTime(2050,1,1),
                      context: context,
                  ).then((picked){
                    if(picked != null){
                      ref.read(repeatEndDate(event).notifier).state = picked;
                    }
                  });
                },
                child: Text(
                  '${endDate.year}年${endDate.month}月${endDate.day}日',
                  style: const TextStyle(
                    color: Colors.blue,
                    fontSize: 30,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}