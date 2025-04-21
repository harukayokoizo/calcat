import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget eventSummary(String title, String? overview, Color color){
  return Padding(
    padding: const EdgeInsets.only(top: 5.0, bottom: 5.0, right: 5.0),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(
          flex: 2,
          child: Padding(
            padding: overview != null ? const EdgeInsets.all(0.0) : const EdgeInsets.only(top: 5.0, bottom: 5.0),
            child: Text(
              title,
              maxLines: 1,
              style: const TextStyle(
                color: Colors.white, //color.computeLuminance() < 0.5 ? Colors.white : Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        if(overview != null)
          Flexible(
            fit: FlexFit.loose,
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.only(top: 0.0),
              child: Text(
                overview,
                maxLines: 2,
                style: const TextStyle(
                  color: Colors.white, //color.computeLuminance() < 0.5 ? Colors.white : Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
      ],
    ),
  );
}