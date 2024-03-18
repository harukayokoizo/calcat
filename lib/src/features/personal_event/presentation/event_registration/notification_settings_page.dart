import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../application/notification_setting_provider.dart';
import '../../application/event_provider.dart';
import '../../domain/event.dart';

class NotificationSettingsPage extends ConsumerWidget{
 Event event;
  NotificationSettingsPage(this.event, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref){
    final notification = ref.read(notificationList);
    final checkList = ref.watch(notificationCheckList(event));
    return Scaffold(
      appBar: AppBar(
        elevation: 5,
        title: Text('通知設定'),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () {
              if(checkList.isNotEmpty){
                ref.read(eventFormStateProvider(event).notifier).changeNotification(checkList);
              }
              Navigator.of(context).pop();
            },
            child: const Padding(
              padding: EdgeInsets.only(right: 16.0),
              child: Text(
                "保存",
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.grey,
                    fontWeight: FontWeight.w700
                ),
              ),
            ),
          ),
        ],
      ),
      body: ListView.builder(
          itemCount: 10,
          itemBuilder: (BuildContext context, int index){
            bool check = checkList.contains(index) ? true : false;
            return Container(
              decoration: const BoxDecoration(
                border: Border(
                    top: BorderSide(color: Colors.grey, width: 1.0),
                    bottom: BorderSide(color: Colors.grey, width: 1.0)
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                child: Row(
                  children: [
                    Text(
                      notification[index],
                      style: const TextStyle(
                        fontSize: 18,
                        //fontWeight: FontWeight.bold
                      ),
                    ),
                    const Expanded(
                      child: SizedBox(),
                    ),
                    Checkbox(
                      value: check,
                      onChanged: (value){
                        final newList = checkList.toList();
                        if(checkList.contains(index)){
                          newList.remove(index);
                          ref.read(notificationCheckList(event).notifier).state = [...newList];
                        }else{
                          newList.add(index);
                          ref.read(notificationCheckList(event).notifier).state = [...newList];
                        }
                      },
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
      ),
    );
  }
}