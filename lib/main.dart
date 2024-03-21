import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:share_calendar/firebase_options.dart';
import 'package:share_calendar/src/features/authentication/application/user_provider.dart';
import 'package:share_calendar/src/features/authentication/presentation/login_page.dart';
import 'package:share_calendar/src/features/calendar/presentation/calendar/list/calendar_list.dart';
import 'package:share_calendar/src/features/calendar/presentation/search/search_page.dart';
import 'package:share_calendar/src/features/personal_event/presentation/calendar.dart';

Future<void> main() async {
  // main()の中で非同期処理を行う際には、下記を実行しなければいけないらしい
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  Intl.defaultLocale = 'ja_JP';
  await initializeDateFormatting('ja');
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
    const SearchPageController(),
    const AllCalendarList(),
    const PersonalCalendarPage()
  ];

  @override
  Widget build(BuildContext context) {
    // return CupertinoTabScaffold(
    //     tabBar: CupertinoTabBar(
    //       items: const <BottomNavigationBarItem> [
    //         BottomNavigationBarItem(
    //           icon: Icon(Icons.search),
    //           label: 'Search',
    //         ),
    //         BottomNavigationBarItem(
    //           icon: Icon(Icons.star),
    //           label: 'Calendar',
    //         ),
    //         BottomNavigationBarItem(
    //           icon: Icon(Icons.calendar_month),
    //           label: 'My Calendar',
    //         ),
    //       ],
    //       // onTap: _onItemTapped(index), // 実は無くても動く
    //       // currentIndex: _selectedIndex, // 実は無くても動く
    //     ),
    //     tabBuilder: (context, index) {
    //       switch (index) {
    //         case 0:
    //           return CupertinoTabView(builder: (context) {
    //             return const CupertinoPageScaffold(
    //               resizeToAvoidBottomInset: false,
    //                 child: SearchPage()
    //             );
    //           });
    //         case 1:
    //           return CupertinoTabView(builder: (context) {
    //             return const CupertinoPageScaffold(
    //                 resizeToAvoidBottomInset: false,
    //                 child: CalendarList()
    //             );
    //           });
    //         case 2:
    //           return CupertinoTabView(builder: (context) {
    //             return PersonalCalendarPage();const CupertinoPageScaffold(
    //                 child: PersonalCalendarPage(),
    //             );
    //           });
    //         default:
    //           return Container();
    //       }
    //     }
    // );
    final tabItems = [
      const BottomNavigationBarItem(
        icon: Icon(Icons.search),
        label: 'Search',
      ),
      const BottomNavigationBarItem(
        icon: Icon(Icons.star),
        label: 'Calendar',
      ),
      const BottomNavigationBarItem(
        icon: Icon(Icons.calendar_month),
        label: 'My Calendar',
      ),
    ];

    return Scaffold(
      //appBar: AppBar(),
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

class Tab(){
return CupertinoTabScaffold(
        tabBar: CupertinoTabBar(
          items: const <BottomNavigationBarItem> [
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: 'Search',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.star),
              label: 'Calendar',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_month),
              label: 'My Calendar',
            ),
          ],
          // onTap: _onItemTapped(index), // 実は無くても動く
          // currentIndex: _selectedIndex, // 実は無くても動く
        ),
        tabBuilder: (context, index) {
          switch (index) {
            case 0:
              return CupertinoTabView(builder: (context) {
                return const CupertinoPageScaffold(
                  //  navigationBar: CupertinoNavigationBar(
                  // //leading: Icon(), // ページのヘッダ左のアイコン
                  // ),
                    child: SearchPage()
                );
              });
            case 1:
              return CupertinoTabView(builder: (context) {
                return const CupertinoPageScaffold(
                  //  navigationBar: CupertinoNavigationBar(
                  // //leading: Icon(), // ページのヘッダ左のアイコン
                  // ),
                    child: CalendarList()
                );
              });
            case 2:
              return CupertinoTabView(builder: (context) {
                return const CupertinoPageScaffold(
                  //  navigationBar: CupertinoNavigationBar(
                  // //leading: Icon(), // ページのヘッダ左のアイコン
                  // ),
                    child: PersonalCalendarPage()
                );
              });
            default:
              return Container();
          }
        }
    );
}
*/

