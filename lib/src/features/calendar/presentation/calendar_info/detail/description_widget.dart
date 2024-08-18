import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/calendar.dart';

class CalendarDescriptionWidget extends ConsumerWidget{
  final Calendar calendar;
  const CalendarDescriptionWidget(this.calendar, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref){
    final String description = calendar.description != null ? calendar.description! : 'no';
    return Padding(
      padding: const EdgeInsets.only(top: 2.0, right: 30, left: 30, bottom: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            style: const TextStyle(
              fontSize: 15,
              color: Colors.black,
            ),
            initialValue: description,
            enabled: false,
            // style: const TextStyle(color: Colors.black),
            keyboardType: TextInputType.multiline,
            maxLines: null,
            decoration: const InputDecoration(
                fillColor: Colors.white,
                filled: true,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10.0),
                      bottomRight: Radius.circular(10.0),
                    ),
                    borderSide: BorderSide.none
                ),
                contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10)
            ),
          )
        ],
      ),
    );
  }
}