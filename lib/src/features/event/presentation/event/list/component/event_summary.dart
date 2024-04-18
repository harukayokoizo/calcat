import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget eventSummary(String title, String? overview, int color){
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Flexible(
        flex: 1,
        child: Text(title,
          style: TextStyle(
            color: Color(color).computeLuminance() < 0.5 ? Colors.white : Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      if(overview != null)
        Flexible(
          flex: 2,
          child: Padding(
            padding: const EdgeInsets.only(right: 5.0, bottom: 5.0),
            child: Text(overview,
              style: TextStyle(
                color: Color(color).computeLuminance() < 0.5 ? Colors.white : Colors.black,
                fontSize: 15,
                //fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
    ],
  );
}