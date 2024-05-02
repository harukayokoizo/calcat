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
  bool loading = false;
  @override

  Widget build(BuildContext context){
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double deviceHeight = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: (){
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: Stack(
          children: [
            SizedBox(
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
                        controller: mailTextController,
                        decoration: const InputDecoration(
                          hintText: 'メールアドレス',
                          border: OutlineInputBorder(),
                        ),
                        onChanged: (value){
                          setState(() {});
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
                        onChanged: (value){
                          setState(() {});
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20.0),
                    child: SizedBox(
                      width: deviceWidth * 0.8,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: mailTextController.text.isEmpty || passTextController.text.isEmpty ? null : () {
                          FocusScope.of(context).unfocus();
                          setState(() {
                            loading = true;
                          });
                          ref.read(authenticateProvider).signInAccount(mailTextController.text, passTextController.text).then((message){
                            setState(() {
                              loading = false;
                            });
                            if(message == 'success'){
                              ref.read(userControllerProvider.notifier).changeTopPage();
                            }else{
                              passTextController.clear();
                              setState(() {});
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  backgroundColor: Colors.red,
                                  content: Text(
                                    message,
                                    style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold
                                    ),
                                  ),
                                ),
                              );
                            }
                          });
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
            if(loading)
              Container(
                height: deviceHeight,
                width: deviceWidth,
                color: Colors.black.withOpacity(0.5),
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
          ],
        ),
      ),
    );
  }
}