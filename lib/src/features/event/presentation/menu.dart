import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_calendar/src/features/authentication/presentation/account_page.dart';

import '../../../common_widgets/application/common_provider.dart';
import '../../authentication/application/mail_auth.dart';
import '../../authentication/application/user_provider.dart';
import '../../authentication/data/token_repositories.dart';
import '../../authentication/data/user_repositories.dart';
import '../../authentication/presentation/delete_account_page.dart';
import '../../authentication/presentation/support/support_list.dart';

class MenuModal extends ConsumerWidget{
  const MenuModal({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref){
    final deviceHeight = MediaQuery.of(context).size.height;
    final safeArea = MediaQuery.of(context).padding.top;
    final currentUser = ref.read(currentUserProvider);
    final packageInfo = ref.read(packageInfoProvider);
    return SafeArea(
      bottom: false,
      child: Container(
        height: 250,
        color: Colors.white,
        child: Scaffold(
          body: LayoutBuilder(
            builder: (context, constraint) {
              return Column(
                children: [
                  SizedBox(
                    height: constraint.maxHeight * 0.7,
                    child: ListView(
                      children: [
                        InkWell(
                          onTap: (){
                            showCupertinoModalPopup(
                              context: context,
                              builder: (BuildContext context) {
                                return const SupportList();
                              },
                            );
                          },
                          child: const ListTile(
                            leading: Icon(Icons.settings),
                            title: Text('サポート'),
                          ),
                        ),
                        InkWell(
                          onTap: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                fullscreenDialog: true,
                                builder: (context) => const AccountPage(),
                              ),
                            ).then((value){
                              if(value){
                                Navigator.pop(context);
                              }
                            });
                          },
                          child: const ListTile(
                            leading: Icon(Icons.person),
                            title: Text('アカウント'),
                          ),
                        ),
                        if(currentUser != null)
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
                                            ref.read(authenticateProvider).signOut().then((value){
                                              Navigator.pop(context, false);
                                            });
                                            // ref.read(tokenRepositories).deleteUser().then(
                                            //   (value){
                                            //     if(value == null){
                                            //       ref.read(authenticateProvider).signOut().then((value){
                                            //         Navigator.pop(context, false);
                                            //       });
                                            //     }else{
                                            //       SnackBar(
                                            //         backgroundColor: Colors.red,
                                            //         content: Text(
                                            //           value,
                                            //           style: const TextStyle(
                                            //               fontSize: 15,
                                            //               fontWeight: FontWeight.bold
                                            //           ),
                                            //         ),
                                            //       );
                                            //     }
                                            //   }
                                            // );
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
                          ),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10.0, left: 24.0, right: 16.0),
                      child: Text(
                        'バージョン： ${packageInfo!.version}',
                        style: const TextStyle(
                            fontSize: 12.0
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }
          ),
        ),
      ),
    );
  }
}