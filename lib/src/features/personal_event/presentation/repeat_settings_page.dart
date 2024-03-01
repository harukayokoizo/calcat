import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RepeatSettingsPage extends ConsumerWidget{
  const RepeatSettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref){
    return Scaffold(
      appBar: AppBar(
        title: Text('繰り返し設定'),
        centerTitle: true,
      ),
      body: Container(),
    );
  }
}