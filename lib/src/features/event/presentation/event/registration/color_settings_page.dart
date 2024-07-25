import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../application/color_setting_provider.dart';
import '../../../application/event_provider.dart';
import '../../../domain/event.dart';
import '../detail/color_detail.dart';

class ColorSettingsPage extends ConsumerWidget{
  Event event;
  ColorSettingsPage(this.event, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref){
    final colors = ref.read(colorList);
    final colorKey = ref.watch(colorCheck(event));
    return Scaffold(
      appBar: AppBar(
        elevation: 5,
        title: const Text('色設定'),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () {
              ref.read(eventFormStateProvider(event).notifier).changeColor(colorKey);
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
            // Color color = getColor(colors, index);
            Map<String,int> color = colors[index];
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: GestureDetector(
                onTap: (){
                  final color = colors[index];
                  ref.read(colorCheck(event).notifier).state = color['key']!;
                },
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(color['color']!),
                      ),
                    ),
                    if(index == getColorKey(colors, colorKey))
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

int getColorKey(List<Map<String, int>> colorList, int colorKey){
  int index = 0;
  colorList.asMap().forEach((key, value) {
    if (value['key'] == colorKey) {
      index = key;
    }
  });
  return index;
}