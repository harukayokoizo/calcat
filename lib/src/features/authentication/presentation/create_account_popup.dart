import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:share_calendar/src/features/authentication/presentation/create_account_page.dart';

import '../../calendar/presentation/calendar_info/detail/icon_widget.dart';

class CreateAccountPopup extends StatelessWidget{
  const CreateAccountPopup({super.key});

  @override
  Widget build(BuildContext context){
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double deviceHeight = MediaQuery.of(context).size.height;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        AlertDialog(
          titlePadding: const EdgeInsets.fromLTRB(24, 15, 24, 0),
          actionsAlignment: MainAxisAlignment.center,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12), //丸み
          ),
          title: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 5.0),
                child: Align(
                  alignment: Alignment.topRight,
                  child: GestureDetector(
                    child: const CircularIcon(
                      icon: Icons.clear,
                      backgroundColor: Colors.grey,
                      iconColor: Colors.white,
                      size: 20,
                    ),
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              ),
              const Text(
                'カレンダーを作成して予定を公開するにはCalCatアカウントの登録が必要です。',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          content: Image.asset(
            width: deviceWidth / 3,
            height: deviceWidth / 3,
            'images/calcat.png',
            fit: BoxFit.contain,
          ),
          actions: <Widget>[
            TextButton(
              onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CreateAccountPage(),
                  ),
                );
              },
              style: TextButton.styleFrom(
                backgroundColor: Colors.purple,
                fixedSize: Size(deviceWidth, 45),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10), // 角丸を12にする
                ),
              ),
              child: const Text(
                'アカウント登録',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}