import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_calendar/src/features/authentication/presentation/mail_send_page.dart';

import '../../../common_widgets/application/common_provider.dart';
import '../../../common_widgets/presentation/error_message_widget.dart';
import '../application/mail_auth.dart';
import '../application/user_provider.dart';
import 'create_account_page.dart';

class LoginPage extends ConsumerStatefulWidget{
  const LoginPage({super.key});

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends ConsumerState<LoginPage>{
  final passTextController = TextEditingController();
  final mailTextController = TextEditingController();
  late String mailAddress;
  late String password;
  late String errorMessage = '';
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
            if(errorMessage != '')
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: ErrorMessageWidget(errorMessage)
              ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: SizedBox(
                width: deviceWidth * 0.8,
                child: TextFormField(
                  controller: mailTextController,
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
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: SizedBox(
                width: deviceWidth * 0.8,
                child: TextFormField(
                  controller: passTextController,
                  decoration: const InputDecoration(
                    hintText: 'パスワード',
                    border: OutlineInputBorder(),
                  ),
                  // onChanged: (value){
                  //   setState(() {
                  //     password = value;
                  //   });
                  // },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: SizedBox(
                width: deviceWidth * 0.8,
                height: 50,
                child: ElevatedButton(
                  onPressed: () async{
                    String message = await ref.read(authenticateProvider).signInAccount(mailTextController.text, passTextController.text);
                    if(message == 'success'){
                      ref.read(userControllerProvider.notifier).changeTopPage();
                    }else{
                      passTextController.clear();
                      mailTextController.clear();
                      setState(() {
                        errorMessage = message;
                      });
                    }
                  },
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
              width: deviceWidth * 0.8,
              child: GestureDetector(
                onTap: () async{
                  await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const MailSendPage(),
                    ),
                  );
                  setState(() {
                    errorMessage = '';
                  });
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
                  recognizer: TapGestureRecognizer()..onTap =()async{
                    await Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const CreateAccountPage(),
                      ),
                    );
                    setState(() {
                      errorMessage = '';
                    });
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