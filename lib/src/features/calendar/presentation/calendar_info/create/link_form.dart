import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_calendar/src/features/calendar/presentation/calendar_info/detail/icon_widget.dart';

import '../../../application/calendar_provider.dart';
import '../../../domain/calendar.dart';
import 'link_setting_form.dart';


class CalendarLinkForm extends ConsumerWidget{
  final Calendar calendar;
  const CalendarLinkForm(this.calendar, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref){
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double deviceHeight = MediaQuery.of(context).size.height;
    Calendar calendarState = ref.watch(calendarStateProvider(calendar));
    final calendarLink = calendarState.calendarLink;

    return Padding(
      padding: const EdgeInsets.only(top: 10, right: 30, left: 30, bottom: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 5.0),
            child: Row(
              children: [
                const Text(
                  'リンク',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(30),
                    onTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => CalendarLinkSettingForm(calendar, null),
                        ),
                      );
                    },
                    child: const CircularIcon(
                      backgroundColor: Colors.blueAccent,
                      icon: Icons.add,
                      iconColor: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          if(calendarLink != null)
            for(int i = 0; i < calendarLink.length; i++)
              InkWell(
                borderRadius: BorderRadius.only(
                    topLeft: i == 0 ? const Radius.circular(10) : const Radius.circular(0),
                    topRight: i == 0 ? const Radius.circular(10) : const Radius.circular(0),
                    bottomLeft: i == calendarLink.length - 1 ? const Radius.circular(10) : const Radius.circular(0),
                    bottomRight: i == calendarLink.length - 1 ? const Radius.circular(10) : const Radius.circular(0),
                ),
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CalendarLinkSettingForm(calendar, calendarLink[i]),
                    ),
                  );
                },
                child: Container(
                  width: deviceWidth,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(
                      top: const BorderSide(color: Color(0xFFF5F5F5), width: 1.0),
                      left: const BorderSide(color: Color(0xFFF5F5F5), width: 1.0),
                      right: const BorderSide(color: Color(0xFFF5F5F5), width: 1.0),
                      bottom: i == calendarLink.length - 1 ? const BorderSide(color: Color(0xFFF5F5F5), width: 1.0) : BorderSide.none,
                    ),
                    borderRadius: BorderRadius.only(
                      topLeft: i == 0 ? const Radius.circular(10) : const Radius.circular(0),
                      topRight: i == 0 ? const Radius.circular(10) : const Radius.circular(0),
                      bottomLeft: i == calendarLink.length - 1 ? const Radius.circular(10) : const Radius.circular(0),
                      bottomRight: i == calendarLink.length - 1 ? const Radius.circular(10) : const Radius.circular(0),
                    ),
                  ),
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      return Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          children: [
                            SizedBox(
                              width: constraints.maxWidth * 0.8,
                              child: Text(
                                calendarLink[i]['name']!,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                            const Spacer(),
                            const Icon(
                              Icons.arrow_forward_ios,
                              size: 18,
                            ),
                          ],
                        ),
                      );
                    }
                  ),
                ),
              )
        ],
      ),
    );
  }
}