import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class PasswordResetCompletePage extends StatefulWidget{
  const PasswordResetCompletePage({super.key});

  @override
  State<PasswordResetCompletePage> createState() => _PasswordResetCompletePageState();
}

class _PasswordResetCompletePageState extends State<PasswordResetCompletePage>{
  @override

  Widget build(BuildContext context){
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SizedBox(
        width: deviceWidth,
        height: deviceHeight,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(flex: 2),
            SizedBox(
              width: deviceWidth * 0.8,
              child: const Text(
                'パスワードを設定しました。',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  //fontWeight: FontWeight.bold
                ),
              )
            ),
            const Spacer(flex: 3,),
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: SizedBox(
                width: deviceWidth * 0.8,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
                    //side: BorderSide(color: Colors.black)
                  ),
                  child: const Text(
                    "ログイン画面に戻る",
                    style: TextStyle(
                        fontSize: 20
                    ),
                  ),

                ),
              ),
            ),
            const Spacer(flex: 1,),
          ],
        ),
      ),
    );
  }
}