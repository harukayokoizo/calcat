import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../application/personal_event_provider.dart';
import '../../domain/personal_event.dart';

class OverViewForm extends ConsumerWidget{
  PersonalEvent? event;
  OverViewForm(this.event, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref){
    String? initialOverView = event != null ? event!.event : '';
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          //top: BorderSide(color: Colors.grey, width: 1.0),
            bottom: BorderSide(color: Colors.grey, width: 1.0)
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 10.0),
        child: TextFormField(
          initialValue: initialOverView,
          decoration: const InputDecoration(
              hintText: 'イベント内容',
              border: InputBorder.none
          ),
          onChanged: (value){
            ref.read(personalEventFormStateProvider(event).notifier).changeEvent(value);
          },
        ),
      ),
    );
  }
}