import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_calendar/src/features/authentication/application/user_provider.dart';
import 'package:share_calendar/src/features/authentication/presentation/password_set_page.dart';

import '../../../common_widgets/application/common_provider.dart';
import '../application/mail_auth.dart';
import '../data/user_repositories.dart';
import 'my_account_page.dart';
import 'no_account_page.dart';

class AccountPage extends ConsumerStatefulWidget{
  const AccountPage({super.key});

  @override
  AccountPageState createState() => AccountPageState();
}

class AccountPageState extends ConsumerState<AccountPage>{
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
    final authState = ref.watch(authStateChangeProvider);
    print(authState);
    return authState.when(
        data: (currentUser) {
          if(currentUser != null) {
            return MyAccountPage(currentUser);
          }else{
            return const NoAccountPage();
          }
        },
        loading: () => Container(),
        error: (_, __) => Container()
    );
  }
}