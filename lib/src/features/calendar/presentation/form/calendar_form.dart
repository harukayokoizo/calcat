import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CalendarForm extends ConsumerWidget{
  const CalendarForm({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref){
    return Scaffold(
      appBar: AppBar(
        elevation: 3,
        title: const Text('カレンダー作成'),
        centerTitle: true,
      ),
      body: const Column(
        children: [

        ],
      ),
    );
  }
}