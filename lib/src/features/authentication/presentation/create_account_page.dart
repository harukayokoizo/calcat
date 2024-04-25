import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../common_widgets/presentation/error_message_widget.dart';
import '../application/mail_auth.dart';
import '../application/user_provider.dart';
import '../data/user_repositories.dart';

class CreateAccountPage extends ConsumerStatefulWidget{
  const CreateAccountPage({super.key});

  @override
  CreateAccountPageState createState() => CreateAccountPageState();
}

class CreateAccountPageState extends ConsumerState<CreateAccountPage>{
  final passTextController = TextEditingController();
  final mailTextController = TextEditingController();
  final focusNode = FocusNode();
  late String mailAddress;
  late String password;
  late String errorMessage = '';
  @override

  Widget build(BuildContext context){
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(),
      body: Focus(
        focusNode: focusNode,
        child: GestureDetector(
          onTap: focusNode.requestFocus,
          child: SizedBox(
            width: deviceWidth,
            height: deviceHeight,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if(errorMessage == '')
                  const Spacer(flex: 1,),
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
                        autofocus: true,
                        textInputAction: TextInputAction.next,
                        controller: mailTextController,
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
                        controller: passTextController,
                        decoration: const InputDecoration(
                          hintText: 'パスワード',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ),
                  const Spacer(flex: 6,),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20.0),
                    child: SizedBox(
                      width: deviceWidth * 0.8,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: (){
                          ref.read(authenticateProvider).createAccount(mailTextController.text, passTextController.text)
                              .then((message){
                                if(message == 'success'){
                                  ref.read(userRepositories).controlUser().then((value){
                                    Navigator.pop(
                                      context,
                                    );
                                    ref.read(userControllerProvider.notifier).changeTopPage();
                                  });
                                }else{
                                  passTextController.clear();
                                  mailTextController.clear();
                                  setState(() {
                                    errorMessage = message;
                                  });
                                }
                          });
                        },
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
        ),
      ),
    );
  }
}