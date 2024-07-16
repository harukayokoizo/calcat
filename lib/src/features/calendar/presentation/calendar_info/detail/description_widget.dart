import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/calendar.dart';

class CalendarDescriptionWidget extends ConsumerWidget{
  Calendar calendar;
  CalendarDescriptionWidget(this.calendar, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref){
    final String description = calendar.description != null ? calendar.description! : 'no';
    return Padding(
      padding: const EdgeInsets.only(top: 10, right: 30, left: 30, bottom: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(bottom: 5.0),
            child: Text(
              '概要',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          TextFormField(
            initialValue: description,
            enabled: false,
            style: const TextStyle(color: Colors.black),
            keyboardType: TextInputType.multiline,
            maxLines: null,
            decoration: InputDecoration(
                fillColor: const Color(0xFFE5E5E5),
                filled: true,
                border:OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide.none
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10)
            ),
          )
        ],
      ),
    );
  }
}