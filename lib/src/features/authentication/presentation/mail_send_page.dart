import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../application/mail_auth.dart';

class MailSendPage extends ConsumerStatefulWidget{
  const MailSendPage({super.key});

  @override
  MailSendPageState createState() => MailSendPageState();
}

class MailSendPageState extends ConsumerState{
  late String mailAddress;
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
                  onChanged: (value){
                    setState(() {
                      mailAddress = value;
                    });
                  },
                ),
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.only(bottom: 20.0),
            //   child: SizedBox(
            //     width: deviceWidth * 0.8,
            //     child: TextFormField(
            //       decoration: const InputDecoration(
            //         hintText: 'パスワード',
            //         border: OutlineInputBorder(),
            //       ),
            //     ),
            //   ),
            // ),
            const Spacer(flex: 5,),
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: SizedBox(
                width: deviceWidth * 0.8,
                height: 50,
                child: ElevatedButton(
                  onPressed: () async{
                    await ref.read(authenticateProvider).sendPasswordResetEmail(mailAddress);
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
                    //side: BorderSide(color: Colors.black)
                  ),
                  child: const Text(
                    "メールを送信",
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