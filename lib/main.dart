import 'package:cloud_functions/cloud_functions.dart';
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
import 'package:share_calendar/src/features/push_notification/application/push_notification.dart';
import 'package:share_calendar/tab_navigator.dart';

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
    ref.read(pushNotification);
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

  TabItem _currentTab = TabItem.search;
  final Map<TabItem, GlobalKey<NavigatorState>> _navigatorKeys = {
    TabItem.search: GlobalKey<NavigatorState>(),
    TabItem.calendar: GlobalKey<NavigatorState>(),
    TabItem.myCalendar: GlobalKey<NavigatorState>(),
  };

  @override
  Widget build(BuildContext context) {
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
      body: Stack(
        children: <Widget>[
          _buildTabItem(
            TabItem.search,
            '/search',
          ),
          _buildTabItem(
            TabItem.calendar,
            '/list',
          ),
          _buildTabItem(
            TabItem.myCalendar,
            '/calendar',
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: number,
        items: tabItems,
        onTap: (index) {
          number = index;
          onSelect(TabItem.values[index]);
        },
      )
    );
  }

  Widget _buildTabItem(
      TabItem tabItem,
      String root,
      ) {
    return Offstage(
      offstage: _currentTab != tabItem,
      child: TabNavigator(
        navigationKey: _navigatorKeys[tabItem],
        tabItem: tabItem,
        routerName: root,
      ),
    );
  }

  void onSelect(TabItem tabItem) {
    if (_currentTab == tabItem) {
      _navigatorKeys[tabItem]?.currentState?.popUntil((route) => route.isFirst);
    } else {
      setState(() {
        _currentTab = tabItem;
      });
    }
  }

  Future<bool> onWillPop() async {
    final isFirstRouteInCurrentTab = !await _navigatorKeys[_currentTab]!.currentState!.maybePop();
    if (isFirstRouteInCurrentTab) {
      if (_currentTab != TabItem.myCalendar) {
        onSelect(TabItem.myCalendar);
        return false;
      }
    }
    return isFirstRouteInCurrentTab;
  }
}

enum TabItem{
  search,
  calendar,
  myCalendar,
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
}*/