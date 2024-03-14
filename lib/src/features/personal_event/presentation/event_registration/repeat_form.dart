import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:share_calendar/src/features/personal_event/presentation/event_registration/repeat_settings_page.dart';

import '../../application/event_provider.dart';
import '../../application/repeat_setting_provider.dart';
import '../../domain/event.dart';

class RepeatForm extends ConsumerWidget{
  Event? event;
  RepeatForm(this.event, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref){
    DateFormat endDateFormat = DateFormat("MM/dd");
    final repeat = ref.read(repeatList);
    final ev = ref.read(eventFormStateProvider(event));
    final double deviceWidth = MediaQuery.of(context).size.width;
    String text = '';
    if(ev.repeat != 0){
      text = '${repeat[ev.repeat!]}, ${endDateFormat.format(ev.endDate!)}まで';
    }
    DateTime from = DateTime(ev.from!.year,ev.from!.month,ev.from!.day);
    DateTime to = DateTime(ev.to!.year,ev.to!.month,ev.to!.day);

    return InkWell(
      onTap: (){
        if(from.isAtSameMomentAs(to)){
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => RepeatSettingsPage(event),
            ),
          );
        }else{
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              backgroundColor: Colors.red,
              content: Text(
                '日付をまたぐ行動を繰り返すことはできません。',
                style: TextStyle(
                  fontSize: 15,
                  //fontWeight: FontWeight.bold
                ),
              ),
            ),
          );
        }
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
              const Icon(Icons.repeat),
              const Padding(
                padding: EdgeInsets.only(left: 4.0),
                child: Text(
                  '繰り返し',
                  style: TextStyle(
                    fontSize: 18,
                    //fontWeight: FontWeight.bold
                  ),
                ),
              ),
              if(text.isNotEmpty)
                Expanded(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15.0),
                      child: Text(text,
                        style: const TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ),
              if(text.isEmpty)
                const Expanded(child: SizedBox()),
              const Icon(Icons.arrow_forward_ios)
            ],
          ),
        ),
      ),
    );
  }
}