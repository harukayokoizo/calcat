import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class CreateAccountPage extends StatefulWidget{
  const CreateAccountPage({super.key});

  @override
  State<CreateAccountPage> createState() => _CreateAccountPageState();
}

class _CreateAccountPageState extends State<CreateAccountPage>{
  @override

  Widget build(BuildContext context){
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(),
      body: SizedBox(
        width: deviceWidth,
        height: deviceHeight,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(flex: 1,),
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: SizedBox(
                width: deviceWidth * 0.8,
                child: TextFormField(
                  decoration: const InputDecoration(
                    hintText: 'メールアドレス',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: SizedBox(
                width: deviceWidth * 0.8,
                child: TextFormField(
                  decoration: const InputDecoration(
                    hintText: 'パスワード',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
            ),
            const Spacer(flex: 5,),
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
                    "アカウント作成",
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