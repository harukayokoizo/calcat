import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget eventSummary(String title, String? overview){
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Flexible(
        flex: 1,
        child: Text(title,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 20,
            //fontWeight: FontWeight.bold,
          ),
        ),
      ),
      if(overview != null)
        Flexible(
          flex: 2,
          child: Text(overview,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 15,
              //fontWeight: FontWeight.bold,
            ),
          ),
        ),
    ],
  );
}