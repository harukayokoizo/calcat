import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ColorForm extends StatelessWidget{
  const ColorForm({super.key});

  @override
  Widget build(BuildContext context){
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double deviceHeight = MediaQuery.of(context).size.height;

    return InkWell(
      onTap: (){

      },
      child: Container(
        width: deviceWidth,
        decoration: const BoxDecoration(
          border: Border(
              bottom: BorderSide(color: Colors.grey, width: 1.0)
          ),
        ),
        child: const Padding(
          padding: EdgeInsets.all(10.0),
          child: Row(
            children: [
              Icon(Icons.color_lens_outlined),
              Padding(
                padding: EdgeInsets.only(left: 4.0),
                child: Text(
                  '色',
                  style: TextStyle(
                    fontSize: 18,
                    //fontWeight: FontWeight.bold
                  ),
                ),
              ),
              Expanded(
                child: SizedBox(),
              ),
              Icon(Icons.arrow_forward_ios)
            ],
          ),
        ),
      ),
    );
  }
}