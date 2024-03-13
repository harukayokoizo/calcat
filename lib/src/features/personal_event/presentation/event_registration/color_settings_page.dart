import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../application/color_setting_provider.dart';
import '../../application/personal_event_provider.dart';
import '../../domain/personal_event.dart';

class ColorSettingsPage extends ConsumerWidget{
  PersonalEvent? event;
  ColorSettingsPage(this.event, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref){
    final colors = ref.read(colorList);
    final colorCode = ref.watch(colorCheck(event));
    return Scaffold(
      appBar: AppBar(
        elevation: 5,
        title: Text('色設定'),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () {
              ref.read(personalEventFormStateProvider(event).notifier).changeColor(colorCode);
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
      body: Padding(
        padding: const EdgeInsets.only(top: 20.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisSpacing: 10,     //ボックス左右間のスペース
            mainAxisSpacing: 10,      //ボックス上下間のスペース
            crossAxisCount: 4,        //ボックスを横に並べる数
          ),
          itemCount: colors.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: GestureDetector(
                onTap: (){
                  ref.read(colorCheck(event).notifier).state = index;
                },
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(colors[index]),
                      ),
                    ),
                    if(index == colorCode)
                      const Icon(
                        Icons.check,
                        size: 30,
                        color: Colors.white,
                      ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}