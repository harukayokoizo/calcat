import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget drawerWidget(){
  return Drawer(
    child: ListView(children: [
      ListTile(
        title: const Text('アカウント'),
        onTap: () {

        },
      ),
    ],),
  );
}