import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_calendar/src/features/authentication/presentation/password_set_page.dart';

import '../../../common_widgets/application/common_provider.dart';
import '../application/mail_auth.dart';
import '../application/user_provider.dart';
import '../data/user_repositories.dart';

class DeleteAccountPage extends ConsumerStatefulWidget{
  const DeleteAccountPage({super.key});

  @override
  DeleteAccountPageState createState() => DeleteAccountPageState();
}

class DeleteAccountPageState extends ConsumerState<DeleteAccountPage>{
  final passTextController = TextEditingController();
  final mailTextController = TextEditingController();
  final focusNode = FocusNode();
  bool loading = false;
  @override

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context){
    final user = ref.read(firebaseAuthProvider).currentUser;
    final email = user?.email.toString() ?? '';
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double deviceHeight = MediaQuery.of(context).size.height;
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            // title: const Text('アカウント削除'),
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
                      width: deviceWidth * 0.9,
                      child: Column(
                        children: [
                          Card(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(0),
                            ),
                            child: ListTile(
                              contentPadding: const EdgeInsets.fromLTRB(12, 10, 5, 10),
                              title: Text(email),
                              leading: const Icon(Icons.account_circle),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'アカウントを削除すると、こちらのアカウントで作成したカレンダーは全て削除されます。',
                              style: TextStyle(
                                fontSize: 12
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Spacer(flex: 10,),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 15.0),
                    child: SizedBox(
                      width: deviceWidth * 0.8,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: (){
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return CupertinoAlertDialog(
                                title: const Text('アカウント削除'),
                                content: const Padding(
                                  padding: EdgeInsets.only(top: 8.0),
                                  child: Text('本当のアカウントを削除しますか？',),
                                ),
                                actions: <Widget>[
                                  TextButton(
                                      child: const Text(
                                        "キャンセル",
                                      ),
                                      onPressed: (){
                                        Navigator.pop(context, false);
                                      }
                                  ),
                                  TextButton(
                                      child: const Text(
                                        "削除",
                                      ),
                                      onPressed: (){
                                        setState(() {
                                          loading = true;
                                        });
                                        Navigator.pop(context, true);
                                      }
                                  ),
                                ],
                              );
                            },
                          ).then((delete){
                            if(delete){
                              ref.read(authenticateProvider).deleteAccount(email).then((value){
                                setState(() {
                                  loading = false;
                                });
                                Navigator.pop(context, true);
                              }).catchError((error){
                                const SnackBar(
                                  backgroundColor: Colors.red,
                                  content: Text(
                                    '再度ログインしてください。',
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold
                                    ),
                                  ),
                                );
                              });
                            }
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
                          //side: BorderSide(color: Colors.black)
                        ),
                        child: const Text(
                          "アカウント削除",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.red,
                          ),
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
                        onPressed: () {
                          Navigator.pop(context,false);
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
                          //side: BorderSide(color: Colors.black)
                        ),
                        child: const Text(
                          "キャンセル",
                          style: TextStyle(
                              fontSize: 20,
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