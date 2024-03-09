import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../application/color_setting_provider.dart';
import '../../application/personal_event_provider.dart';
import '../../domain/personal_event.dart';
import 'color_settings_page.dart';

class ColorForm extends ConsumerWidget{
  PersonalEvent? event;
  ColorForm(this.event, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref){
    final ev = ref.read(personalEventFormStateProvider(event));
    final colors = ref.read(colorList);
    final double deviceWidth = MediaQuery.of(context).size.width;
    int color= 8;
    color = ev.color != null ? ev.color! : 8;

    return InkWell(
      onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ColorSettingsPage(event),
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
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              const Icon(Icons.color_lens_outlined),
              const Padding(
                padding: EdgeInsets.only(left: 4.0),
                child: Text(
                  '色',
                  style: TextStyle(
                    fontSize: 18,
                    //fontWeight: FontWeight.bold
                  ),
                ),
              ),
              const Expanded(
                child: SizedBox(),
              ),
              Container(
                height: 20,
                width: 20,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(colors[color]),
                ),
              ),
              const Icon(Icons.arrow_forward_ios)
            ],
          ),
        ),
      ),
    );
  }
}