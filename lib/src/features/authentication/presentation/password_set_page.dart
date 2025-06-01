import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../application/mail_auth.dart';
import '../application/user_provider.dart';

class SetPasswordPage extends ConsumerStatefulWidget{
  const SetPasswordPage({super.key});

  @override
  SetPasswordPageState createState() => SetPasswordPageState();
}

class SetPasswordPageState extends ConsumerState<SetPasswordPage>{
  final passTextController = TextEditingController();
  final passTextConfirmController = TextEditingController();
  final focusNode = FocusNode();
  bool loading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context){
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double deviceHeight = MediaQuery.of(context).size.height;
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            title: const Text(
              'パスワード設定',
              style: TextStyle(fontSize: 20),
            ),
            automaticallyImplyLeading: false,
          ),
          body: Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: GestureDetector(
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
                          obscureText: true,
                          textInputAction: TextInputAction.next,
                          controller: passTextController,
                          decoration: const InputDecoration(
                            hintText: 'パスワード',
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
                          autofocus: true,
                          obscureText: true,
                          textInputAction: TextInputAction.next,
                          controller: passTextConfirmController,
                          decoration: const InputDecoration(
                            hintText: 'パスワードの確認',
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
                    const Spacer(flex: 10,),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20.0),
                      child: SizedBox(
                        width: deviceWidth * 0.8,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: (passTextController.text.isEmpty || passTextConfirmController.text.isEmpty) ? null : (){
                            if(passTextController.text != passTextConfirmController.text){
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  backgroundColor: Colors.red,
                                  content: Text(
                                    'パスワードが一致しません。',
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold
                                    ),
                                  ),
                                ),
                              );
                            }else{
                              FocusScope.of(context).unfocus();
                              setState(() {
                                loading = true;
                              });
                              ref.read(authenticateProvider).updatePassword(passTextController.text).then((value){
                                ref.read(firstAuthentication.notifier).state = false;
                                Navigator.pop(context);
                              });
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
                            //side: BorderSide(color: Colors.black)
                          ),
                          child: const Text(
                            "パスワード設定",
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