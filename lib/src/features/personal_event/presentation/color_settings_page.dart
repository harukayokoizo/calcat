import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ColorSettingsPage extends ConsumerWidget{
  const ColorSettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref){
    return Scaffold(
      appBar: AppBar(
        title: Text('色設定'),
        centerTitle: true,
      ),
      body: Container(),
    );
  }
}