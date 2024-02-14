import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:share_calendar/src/features/authentication/presentation/mail_send_page.dart';

import 'create_account_page.dart';

class LoginPage extends StatefulWidget{
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>{
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
            const Spacer(flex: 3,),
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
                    "ログイン",
                    style: TextStyle(
                      fontSize: 20
                    ),
                  ),

                ),
              ),
            ),
            SizedBox(
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const MailSendPage(),
                    ),
                  );
                },
                child: const Text(
                  'パスワードはお忘れですか？',
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
              ),
            ),
            const Spacer(flex: 2,),
            RichText(text: TextSpan(
              children: [
                const TextSpan(
                  text: 'アカウントをお持ちでない方は、登録は',
                  style: const TextStyle(color: Colors.black)
                ),
                TextSpan(
                  text: 'こちら',
                  style: const TextStyle(color: Colors.blue),
                  recognizer: TapGestureRecognizer()..onTap =(){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const CreateAccountPage(),
                      ),
                    );
                  }
                )
              ]
            )),
            Spacer(flex: 1)
          ],
        ),
      ),
    );
  }
}