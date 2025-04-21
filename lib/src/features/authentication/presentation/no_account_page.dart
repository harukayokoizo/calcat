import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'create_account_page.dart';
import 'create_account_popup.dart';
import 'login_page.dart';

class NoAccountPage extends StatelessWidget{
  const NoAccountPage({super.key});

  @override
  Widget build(BuildContext context){
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double deviceHeight = MediaQuery.of(context).size.height;
    final safeArea = MediaQuery.of(context).padding.top;
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            // title: const Text('アカウント削除'),
          ),
          body: GestureDetector(
            child: SizedBox(
              width: deviceWidth,
              height: deviceHeight,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 15.0),
                    child: SizedBox(
                      width: deviceWidth * 0.8,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const CreateAccountPage(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
                          //side: BorderSide(color: Colors.black)
                        ),
                        child: const Text(
                          "アカウント作成",
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
                          showCupertinoModalPopup(
                              context: context,
                              builder: (BuildContext context) => SizedBox(
                                height: deviceHeight,
                                child: const LoginPage(),
                              ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
                          //side: BorderSide(color: Colors.black)
                        ),
                        child: const Text(
                          "ログイン",
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
      ],
    );
  }
}