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
  bool loading = false;
  @override

  Widget build(BuildContext context){
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double deviceHeight = MediaQuery.of(context).size.height;
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(),
          body: GestureDetector(
            onTap: focusNode.requestFocus,
            child: SizedBox(
              width: deviceWidth,
              height: deviceHeight,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
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
                          onChanged: (value){
                            setState(() {
                              // mailAddress = value;
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
                          onChanged: (value){
                            setState(() {
                              // password = value;
                            });
                          },
                        ),
                      ),
                    ),
                    const Spacer(flex: 10,),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20.0),
                      child: SizedBox(
                        width: deviceWidth * 0.8,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: mailTextController.text.isEmpty || passTextController.text.isEmpty ? null : (){
                            FocusScope.of(context).unfocus();
                            setState(() {
                              loading = true;
                            });
                            ref.read(authenticateProvider).createAccount(mailTextController.text, passTextController.text).then((message){
                              setState(() {
                                loading = false;
                              });
                              if(message == 'success'){
                                ref.read(userRepositories).controlUser().then((value){
                                  Navigator.pop(
                                    context,
                                  );
                                  ref.read(userControllerProvider.notifier).changeTopPage();
                                });
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
                            "アカウント作成",
                            style: TextStyle(
                                fontSize: 20
                            ),
                          ),

                        ),
                      ),
                    ),
                    const Spacer(flex: 2,),
                ],
              ),
            ),
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
    );
  }
}