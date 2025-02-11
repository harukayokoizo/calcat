import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../application/calendar_provider.dart';
import '../../../domain/calendar.dart';

class DescriptionForm extends ConsumerWidget{
  final Calendar calendar;
  const DescriptionForm(this.calendar, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref){
    return Padding(
      padding: const EdgeInsets.only(top: 2.0, right: 30, left: 30, bottom: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            style: const TextStyle(
                fontSize: 15
            ),
            cursorHeight: 18,
            initialValue: calendar.description,
            keyboardType: TextInputType.multiline,
            maxLines: null,
            decoration: const InputDecoration(
              hintText: '概要',
              fillColor: Colors.white,
              filled: true,
              border:OutlineInputBorder(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10.0),
                    bottomRight: Radius.circular(10.0),
                  ),
                  borderSide: BorderSide.none
              ),
              contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10)
            ),
            onChanged: (value){
              ref.read(calendarStateProvider(calendar).notifier).saveDescription(value);
            },
          )
        ],
      ),
    );
  }
}