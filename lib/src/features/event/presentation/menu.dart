import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../authentication/application/mail_auth.dart';
import '../../authentication/application/user_provider.dart';
import '../../authentication/data/user_repositories.dart';

class MenuModal extends ConsumerWidget{
  const MenuModal({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref){
    return SafeArea(
      bottom: false,
      child: Container(
        height: 100,
        color: Colors.white,
        child: Scaffold(
          body: ListView(
            children: [
              InkWell(
                onTap: (){
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return CupertinoAlertDialog(
                        title: const Text('ログアウト'),
                        content: const Padding(
                          padding: EdgeInsets.only(top: 8.0),
                          child: Text('ログアウトしてもよろしいですか？',),
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
                                "ログアウト",
                              ),
                              onPressed: (){
                                ref.read(userRepositories).deleteUser().then(
                                  (value){
                                    if(value == null){
                                      ref.read(authenticateProvider).signOut().then((value){
                                        Navigator.pop(context, false);
                                      });
                                    }else{
                                      SnackBar(
                                        backgroundColor: Colors.red,
                                        content: Text(
                                          value,
                                          style: const TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold
                                          ),
                                        ),
                                      );
                                    }
                                  }
                                );
                              }
                          ),
                        ],
                      );
                    },
                  ).then((value){
                    Navigator.pop(context);
                  });
                },
                child: const ListTile(
                  leading: Icon(Icons.logout),
                  title: Text('ログアウト'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}