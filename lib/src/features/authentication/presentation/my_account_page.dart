import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_calendar/src/features/authentication/presentation/delete_popup.dart';
import 'package:share_calendar/src/features/authentication/presentation/password_set_page.dart';

import '../../../common_widgets/application/common_provider.dart';
import '../../todo/presentation/common/todo_popup_menu.dart';
import '../application/mail_auth.dart';
import '../data/user_repositories.dart';

class MyAccountPage extends ConsumerWidget{
  final User user;
  const MyAccountPage(this.user, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref){
    final focusNode = FocusNode();
    final email = user.email.toString() ?? '';
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double deviceHeight = MediaQuery.of(context).size.height;
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            title: const Text(
              'アカウント管理',
              style: TextStyle(
                fontSize: 18
              ),
            ),
            actions: const [
              Padding(
                padding: EdgeInsets.all(12.0),
                child: DeletePopupMenu(),
              ),
            ],
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
                    padding: const EdgeInsets.only(top:10.0, bottom: 20.0),
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
                        ],
                      ),
                    ),
                  ),
                  const Spacer(flex: 10,),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}