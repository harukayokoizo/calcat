import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_calendar/src/features/calendar/presentation/calendar_info/search/user_search_results.dart';

import '../../../application/calendar_link_provider.dart';
import '../../../application/calendar_provider.dart';
import '../../../domain/calendar.dart';
import '../../../domain/calendar_document.dart';
import 'delete_link_dialog.dart';

class CalendarLinkSettingForm extends ConsumerWidget {
  final Calendar calendar;
  final Map<String,String>? link;

  const CalendarLinkSettingForm(this.calendar, this.link, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref){
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double deviceHeight = MediaQuery.of(context).size.height;
    final calendarLink = ref.watch(calendarLinkProvider(link));
    String? url = calendarLink['url'];
    String? name = calendarLink['name'];

    return GestureDetector(
      onTap: (){
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'リンクを追加',
            style: TextStyle(fontSize: 18),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: (url == null || url.isEmpty) || (name == null || name.isEmpty) ? null : (){
                  try{
                    FocusScope.of(context).unfocus();
                    final saveLink = {'url': url, 'name': name};
                    bool success = ref.read(calendarStateProvider(calendar).notifier).controlCalendarLink(link, saveLink);
                    if(success){
                      Navigator.pop(context);
                    }else{
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          backgroundColor: Colors.red,
                          content: Text(
                            'リンク名が同じものが既に存在します。',
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                      );
                    }
                  }catch (e){
                    print(e.toString());
                  }
                },
                child: Text(
                  "保存",
                  style: TextStyle(
                      fontSize: 20,
                      color: (url == null || url.isEmpty) || (name == null || name.isEmpty) ? Colors.grey : Colors.blue,
                      fontWeight: FontWeight.w700
                  ),
                ),
              ),
            ),
          ],
        ),
        body: Focus(
          child: GestureDetector(
            child: SizedBox(
              width: deviceWidth,
              height: deviceHeight,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                    child: SizedBox(
                      width: deviceWidth * 0.9,
                      child: TextFormField(
                        initialValue: url,
                        textAlign: TextAlign.left,
                        decoration: const InputDecoration(
                          hintText: 'URL',
                          labelText: 'URL',
                          labelStyle: TextStyle(),
                          contentPadding: EdgeInsets.fromLTRB(10, 20, 12, 20),
                          border: OutlineInputBorder(),
                        ),
                        onChanged: (value){
                          ref.read(calendarLinkProvider(link).notifier).saveUrl(value);
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    width: deviceWidth * 0.9,
                    child: TextFormField(
                      initialValue: name,
                      textAlign: TextAlign.left,
                      decoration: const InputDecoration(
                        hintText: 'リンク名',
                        labelText: 'リンク名',
                        contentPadding: EdgeInsets.fromLTRB(10, 20, 12, 20),
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (value){
                        ref.read(calendarLinkProvider(link).notifier).saveName(value);
                      },
                    ),
                  ),
                  if(link != null)
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: GestureDetector(
                        onTap: (){
                          showCupertinoModalPopup(
                              context: context,
                              // barrierDismissible: false,
                              builder: (BuildContext context) => const DeleteLinkDialog()
                          ).then((value){
                            if(true){
                              ref.read(calendarStateProvider(calendar).notifier).deleteCalendarLink(link!['name']!);
                              Navigator.pop(context);
                            }

                          });
                        },
                        child: const Text(
                          'リンクを削除',
                          style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}