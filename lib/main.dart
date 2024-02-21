import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_calendar/firebase_options.dart';
import 'package:share_calendar/src/common_widgets/application/common_provider.dart';
import 'package:share_calendar/src/features/authentication/application/mail_auth.dart';
import 'package:share_calendar/src/features/authentication/application/user_provider.dart';
import 'package:share_calendar/src/features/authentication/presentation/login_page.dart';
import 'package:share_calendar/src/features/personal_event/presentation/personal_calendar2.dart';

import 'src/features/personal_event/presentation/personal_calendar.dart';

// void main() {
//   runApp(const MyApp());
// }

Future<void> main() async {
  // main()の中で非同期処理を行う際には、下記を実行しなければいけないらしい
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // iOS,androidともに縦向き固定
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(const ProviderScope(child: MyApp()));
  });
  /// MyAppはルートウィジェットです。
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var userCheck = ref.watch(userControllerProvider);

    return MaterialApp(
        title: 'calendar',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: userCheck.when(
            data: (data) {
              if(data == 0) {
                return const TopPage();
              }else if(data == 1) {
                return const LoginPage();
              }
            },
            loading: () => Container(),
            error: (_, __) => Container()
        ),
      );

  }
}

class TopPage extends StatefulWidget{
  const TopPage({super.key});

  @override
  State<TopPage> createState() => TopPageState();
}

class TopPageState extends State<TopPage>{
  int number = 0;
  final List<Widget> _pageList = <Widget>[
    const PersonalCalendarPage(),
    const PersonalCalendarPage2()
  ];

  @override
  Widget build(BuildContext context) {
    final tabItems = [
      const BottomNavigationBarItem(
        icon: Icon(Icons.swipe),
        label: 'Calendar',
      ),
      const BottomNavigationBarItem(
        icon: Icon(Icons.star),
        label: 'favorite',
      ),
      const BottomNavigationBarItem(
        icon: Icon(Icons.people),
        label: 'Profile',
      ),
    ];

    return Scaffold(
      appBar: AppBar(),
      // ignore: invalid_use_of_protected_member
      body: IndexedStack(
        index: number,
        children: _pageList,
      ),
      bottomNavigationBar: BottomNavigationBar(
        // ignore: invalid_use_of_protected_member
        currentIndex: number,
        onTap: (index) {
          setState(() {
            number = index;
          });
        },
        items: tabItems,
      ),
    );
  }

}

/*
class TopPage extends ConsumerWidget{
  const TopPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref){
    return Scaffold(
      appBar: AppBar(),
      body: ElevatedButton(
        onPressed: () async{
          await ref.read(authenticateProvider).signOut();
          ref.read(userControllerProvider.notifier).changeLoginPage();
        },
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
          //side: BorderSide(color: Colors.black)
        ),
        child: const Text(
          "ログインアウト",
          style: TextStyle(
              fontSize: 20
          ),
        ),

      )
    );
  }
}
*/