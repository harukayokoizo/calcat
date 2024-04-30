import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../application/mail_auth.dart';
import '../application/user_provider.dart';

class MailSendPage extends ConsumerStatefulWidget{
  const MailSendPage({super.key});

  @override
  MailSendPageState createState() => MailSendPageState();
}

class MailSendPageState extends ConsumerState{
  final OverlayPortalController _overlayPortalController = OverlayPortalController();
  late String mailAddress;
  @override

  Widget build(BuildContext context){
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double deviceHeight = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: (){
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(),
        body: SizedBox(
          width: deviceWidth,
          height: deviceHeight,
          child: OverlayPortal(
            controller: _overlayPortalController,
            overlayChildBuilder: (context) {
              return Positioned.fill(
                child: Align(
                  alignment: Alignment.center,
                  child: Material(
                    elevation: 4.0,
                    child: Container(
                      width: deviceWidth * 0.8,
                      padding: EdgeInsets.all(8),
                      color: Colors.green,
                      child: Text(
                        'メールを送信しました。',
                        style: TextStyle(
                          color: Colors.green.computeLuminance() < 0.5 ? Colors.white : Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // const Spacer(flex: 1,),
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
                const Spacer(flex: 10,),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: SizedBox(
                    width: deviceWidth * 0.8,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () async{
                        try{
                          FocusScope.of(context).unfocus();
                          ref.read(authenticateProvider).sendPasswordResetEmail(mailAddress).then((value){
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                backgroundColor: Colors.green,
                                content: Text(
                                  'メールを送信しました。',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold
                                  ),
                                ),
                              ),
                            );
                            // _overlayPortalController.toggle();
                            // Future.delayed(const Duration(seconds: 3))
                            //     .then((_) => _overlayPortalController.hide());
                          });
                        }catch (e){
                        }
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
                const Spacer(flex: 2,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}