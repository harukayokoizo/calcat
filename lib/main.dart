import 'dart:io';

import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:share_calendar/firebase_options.dart';
import 'package:share_calendar/src/common_widgets/application/common_provider.dart';
import 'package:share_calendar/src/features/authentication/application/user_provider.dart';
import 'package:share_calendar/src/features/authentication/data/fcm_token_repositories.dart';
import 'package:share_calendar/src/features/authentication/data/user_repositories.dart';
import 'package:share_calendar/src/features/authentication/presentation/login_page.dart';
import 'package:share_calendar/src/features/notification/application/push_notification.dart';
import 'package:share_calendar/tab_navigator.dart';

Future<void> main() async {
  // main()の中で非同期処理を行う際には、下記を実行しなければいけないらしい
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await FirebaseAppCheck.instance.activate(
    androidProvider: AndroidProvider.debug,
    appleProvider: AppleProvider.debug,
    // androidProvider: kReleaseMode ? AndroidProvider.playIntegrity : AndroidProvider.debug,
    // appleProvider: kReleaseMode ? AppleProvider.deviceCheck : AppleProvider.debug,
  );
  // await FirebaseMessaging.instance.deleteToken().then((value){
  //   FirebaseMessaging.instance.getToken();
  // });

  final messagingInstance = FirebaseMessaging.instance;
  if (Platform.isIOS) {
    await messagingInstance.requestPermission();
    // iOSでフォアグランド通知を行うための設定
    await messagingInstance.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(const ProviderScope(child: MyApp()));
  });
  /// MyAppはルートウィジェットです。
}

class MyApp extends ConsumerWidget{
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');

      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification}');
      }
    });
    ref.read(fcmTokenRepositories).connectIsar();
    FirebaseMessaging.instance.onTokenRefresh
        .listen((fcmToken) async{
          await ref.read(userRepositories).controlUser(fcmToken);
        }).onError((err) {
    });

    return const ControlPage();
  }
}

class ControlPage extends ConsumerWidget {
  const ControlPage({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateChangeProvider);

    return MaterialApp(
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('ja'),
        ],
        title: 'calendar',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
          //scaffoldBackgroundColor: const Color(0xFFE5E5E5),
          useMaterial3: true,
        ),
        home: authState.when(
            data: (data) {
              if(data != null) {
                return const TopPage();
              }else{
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