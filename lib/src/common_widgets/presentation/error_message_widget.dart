import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ErrorMessageWidget extends StatelessWidget{
  String errorMessage;

  ErrorMessageWidget(this.errorMessage, {super.key});

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double deviceHeight = MediaQuery.of(context).size.height;
    return Container(
        width: deviceWidth * 0.8,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.red,
        ),
        child: Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                errorMessage,
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500
                ),
              ),
            )
        )
    );
  }

}