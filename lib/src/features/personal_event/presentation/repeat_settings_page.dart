import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../application/personal_event_provider.dart';
import '../application/repeat_setting_provider.dart';

class RepeatSettingsPage extends ConsumerWidget{
  const RepeatSettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref){
    //final personalEvent = ref.read(personalEventFormStateProvider);
    final endDate = ref.watch(repeatEndDate);
    final repeat = ref.read(repeatList);
    print(endDate);
    return Scaffold(
      appBar: AppBar(
        title: Text('繰り返し設定'),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () {
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              '頻度を設定',
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18
              ),
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            itemCount: 4,
            itemBuilder: (BuildContext context, int index){
              //bool check = checkList.contains(index) ? true : false;
              return Container(
                height: 60,
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
                        repeat[index],
                        style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      const Expanded(
                        child: SizedBox(),
                      ),
                      Checkbox(
                        value: false,
                        onChanged: (value){
                          // if(checkList.contains(index)){
                          //   checkList.remove(index);
                          //   ref.read(notificationCheckList.notifier).state = [...checkList];
                          // }else{
                          //   checkList.add(index);
                          //   ref.read(notificationCheckList.notifier).state = [...checkList];
                          // }
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
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              '終了日を設定',
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              DatePicker.showDatePicker(context,
                  showTitleActions: true,
                  minTime: DateTime(2024, 1, 1),
                  maxTime: DateTime(2050, 12, 31),
                  onChanged: (date) {
                    print('change $date');
                  },
                  onConfirm: (date) {
                    print('confirm $date');
                    ref.read(repeatEndDate.notifier).state = date;
                  },
                  currentTime: endDate,
                  locale: LocaleType.jp
              );
            },
            child: Text(
              '${endDate.year}年${endDate.month}月${endDate.day}日',
              style: TextStyle(color: Colors.blue),
            ),
          ),
        ],
      ),
    );
  }
}