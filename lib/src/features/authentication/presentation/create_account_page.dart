import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_calendar/src/features/authentication/presentation/password_set_page.dart';

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

  @override
  void initState() {
    super.initState();
    FirebaseDynamicLinks.instance.onLink.listen((pendingDynamicLinkData) async{
      final email = mailTextController.text;
      final String deepLink = pendingDynamicLinkData.link.toString();
      if (FirebaseAuth.instance.isSignInWithEmailLink(deepLink)) {
        try {
          setState(() {
            loading = true;
          });
          final UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailLink(email: email, emailLink: deepLink).catchError((onError){
            throw '認証に失敗しました。';
          });
          if(userCredential.user != null){
            await ref.read(authenticateProvider).loginAndCreateUser(email, userCredential.user!).then((value){
              // ref.read(firstAuthentication.notifier).state = true;
              // Navigator.pop(context);
              setState(() {
                loading = false;
              });
              showCupertinoModalPopup(
                  context: context,
                  builder: (BuildContext context) => const SetPasswordPage()
              ).then((value){
                Navigator.pop(context);
              });
            });
          }
        } catch (error) {
          setState(() {
            loading = false;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.red,
              content: Text(
                error.toString(),
                style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold
                ),
              ),
            ),
          );
        }
      }
    });
  }

  @override
  Widget build(BuildContext context){
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double deviceHeight = MediaQuery.of(context).size.height;
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            // title: const Text('アカウント作成'),
          ),
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
                        // autofocus: true,
                        textInputAction: TextInputAction.next,
                        controller: mailTextController,
                        decoration: const InputDecoration(
                          hintText: 'メールアドレス',
                          helperStyle: TextStyle(),
                          helperText: '作成するアカウントのメールアドレスを入力してください。',
                          helperMaxLines: 2,
                          contentPadding: EdgeInsets.fromLTRB(10, 20, 12, 20),
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
                        onPressed: mailTextController.text.isEmpty ? null : (){
                          FocusScope.of(context).unfocus();
                          setState(() {
                            loading = true;
                          });
                          ref.read(authenticateProvider).createAccountMailLink(mailTextController.text).then((value){
                            final color = value == null ? Colors.green : Colors.red;
                            final message = value ?? 'メール送信しました。';
                            setState((){
                              loading = false;
                            });
                            ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    backgroundColor: color,
                                    content: Text(
                                      message,
                                      style: const TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold
                                      ),
                                    ),
                                  ),
                                );
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
                          //side: BorderSide(color: Colors.black)
                        ),
                        child: const Text(
                          "メール送信",
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

// class CreateAccountPage extends ConsumerStatefulWidget{
//   const CreateAccountPage({super.key});
//
//   @override
//   CreateAccountPageState createState() => CreateAccountPageState();
// }
//
// class CreateAccountPageState extends ConsumerState<CreateAccountPage>{
//   final passTextController = TextEditingController();
//   final mailTextController = TextEditingController();
//   final focusNode = FocusNode();
//   bool loading = false;
//   @override
//
//   Widget build(BuildContext context){
//     final double deviceWidth = MediaQuery.of(context).size.width;
//     final double deviceHeight = MediaQuery.of(context).size.height;
//     return Stack(
//       children: [
//         Scaffold(
//           appBar: AppBar(),
//           body: GestureDetector(
//             onTap: focusNode.requestFocus,
//             child: SizedBox(
//               width: deviceWidth,
//               height: deviceHeight,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                     Padding(
//                       padding: const EdgeInsets.only(bottom: 20.0),
//                       child: SizedBox(
//                         width: deviceWidth * 0.8,
//                         child: TextFormField(
//                           autofocus: true,
//                           textInputAction: TextInputAction.next,
//                           controller: mailTextController,
//                           decoration: const InputDecoration(
//                             hintText: 'メールアドレス',
//                             border: OutlineInputBorder(),
//                           ),
//                           onChanged: (value){
//                             setState(() {
//                               // mailAddress = value;
//                             });
//                           },
//                         ),
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.only(bottom: 20.0),
//                       child: SizedBox(
//                         width: deviceWidth * 0.8,
//                         child: TextFormField(
//                           controller: passTextController,
//                           decoration: const InputDecoration(
//                             hintText: 'パスワード',
//                             border: OutlineInputBorder(),
//                           ),
//                           onChanged: (value){
//                             setState(() {
//                               // password = value;
//                             });
//                           },
//                         ),
//                       ),
//                     ),
//                     const Spacer(flex: 10,),
//                     Padding(
//                       padding: const EdgeInsets.only(bottom: 20.0),
//                       child: SizedBox(
//                         width: deviceWidth * 0.8,
//                         height: 50,
//                         child: ElevatedButton(
//                           onPressed: mailTextController.text.isEmpty || passTextController.text.isEmpty ? null : (){
//                             FocusScope.of(context).unfocus();
//                             setState(() {
//                               loading = true;
//                             });
//                             ref.read(authenticateProvider).createAccountAndUser(mailTextController.text, passTextController.text).then((message){
//                               if(message == 'success'){
//                                 Navigator.pop(context);
//                               }else{
//                                 passTextController.clear();
//                                 setState(() {});
//                                 ScaffoldMessenger.of(context).showSnackBar(
//                                   SnackBar(
//                                     backgroundColor: Colors.red,
//                                     content: Text(
//                                       message,
//                                       style: const TextStyle(
//                                           fontSize: 15,
//                                           fontWeight: FontWeight.bold
//                                       ),
//                                     ),
//                                   ),
//                                 );
//                               }
//                             });
//                           },
//                           style: ElevatedButton.styleFrom(
//                             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
//                             //side: BorderSide(color: Colors.black)
//                           ),
//                           child: const Text(
//                             "アカウント作成",
//                             style: TextStyle(
//                                 fontSize: 20
//                             ),
//                           ),
//
//                         ),
//                       ),
//                     ),
//                     const Spacer(flex: 2,),
//                 ],
//               ),
//             ),
//           ),
//         ),
//         if(loading)
//           Container(
//             height: deviceHeight,
//             width: deviceWidth,
//             color: Colors.black.withOpacity(0.5),
//             child: const Center(
//               child: CircularProgressIndicator(),
//             ),
//           ),
//       ],
//     );
//   }
// }