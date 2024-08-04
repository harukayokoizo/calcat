import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:share_calendar/firebase_options_dev.dart';
import 'package:share_calendar/src/common_widgets/application/common_provider.dart';
import 'package:share_calendar/src/common_widgets/presentation/app_update_dialog.dart';
import 'package:share_calendar/src/features/authentication/application/user_provider.dart';
import 'package:share_calendar/src/features/authentication/data/fcm_token_repositories.dart';
import 'package:share_calendar/src/features/authentication/data/token_repositories.dart';
import 'package:share_calendar/src/features/authentication/data/user_repositories.dart';
import 'package:share_calendar/src/features/authentication/presentation/login_page.dart';
import 'package:share_calendar/src/features/authentication/presentation/password_set_page.dart';
import 'package:share_calendar/src/features/calendar/application/calendar_list_provider.dart';
import 'package:share_calendar/src/features/calendar/application/event_list_provider.dart';
import 'package:share_calendar/src/features/calendar/domain/calendar.dart';
import 'package:share_calendar/src/features/calendar/domain/calendar_document.dart';
import 'package:share_calendar/src/features/calendar/presentation/list/follow_calendar/calendar.dart';
import 'package:share_calendar/src/features/calendar/presentation/list/published_calendar/calendar.dart';
import 'package:share_calendar/src/features/event/application/event_list_provider.dart';
import 'package:share_calendar/src/features/event/presentation/event/detail/action_sheet.dart';
import 'package:share_calendar/src/features/event/presentation/event/detail/event_detail.dart';
import 'package:share_calendar/src/features/notification/application/push_notification.dart';
import 'package:share_calendar/src/features/notification/domain/payload.dart';
import 'package:share_calendar/src/features/tab_value/application/tab_value_provider.dart';
import 'package:share_calendar/src/features/tab_value/data/tab_value_repositories.dart';
import 'package:share_calendar/src/features/tab_value/domain/tab_value.dart';
import 'package:share_calendar/tab_navigator.dart';
import 'package:table_calendar/table_calendar.dart';
import 'firebase_options_prod.dart';

Future<void> main() async {
  const flavor = String.fromEnvironment('FLAVOR');
  print(flavor);
  // main()の中で非同期処理を行う際には、下記を実行しなければいけないらしい
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // パッケージ情報の取得
  PackageInfo packageInfo = await PackageInfo.fromPlatform();

  // Firebase Remote Confingの設定
  await FirebaseRemoteConfig.instance.setConfigSettings(RemoteConfigSettings(
    fetchTimeout: const Duration(minutes: 1),
    minimumFetchInterval: const Duration(minutes: 5),
  ));

  for (var e in Firebase.apps) {
    print(e.options.projectId);
  }

  // await FirebaseAppCheck.instance.activate(
  //   androidProvider: AndroidProvider.debug,
  //   appleProvider: AppleProvider.debug,
  //   // androidProvider: kReleaseMode ? AndroidProvider.playIntegrity : AndroidProvider.debug,
  //   // appleProvider: kReleaseMode ? AppleProvider.deviceCheck : AppleProvider.debug,
  // );
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

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((_) {
    runApp(
        ProviderScope(
          overrides: [
            // 初期化したinstanceで上書き
            packageInfoProvider.overrideWith((ref) => packageInfo)
          ],
          child: MyApp(),
        )
    );
  });
  /// MyAppはルートウィジェットです。
}

class MyApp extends ConsumerStatefulWidget{
  const MyApp({super.key});

  @override
  ConsumerState createState() => MyAppState();
}

class MyAppState extends ConsumerState{
  late Future<TabValue?> future;
  @override
  void initState() {
    super.initState();
    Future(() async {
      await ref.read(fcmTokenRepositories).connectIsar();
    });

    future = ref.read(tabValueProvider.notifier).getTabValue();

    FirebaseMessaging.instance.onTokenRefresh.listen((fcmToken) async{
      await ref.read(tokenRepositories).controlUser(fcmToken);
    }).onError((err) {});
  }
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: future,
        builder: (BuildContext context, AsyncSnapshot<TabValue?> tabValue) {
          if(tabValue.connectionState == ConnectionState.done) {
            return const MaterialAppClass();
          }else{
            return const SizedBox();
          }
    });
  }
}

// 強制アップデートを促すダイアログ
void _showDialog(BuildContext context) {
  showCupertinoModalPopup(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => const AppUpdateDialog()
  );
}

// 強制アップデートが必要かどうかのチェック
bool checkForceUpdate(String pkgVer) {
  try {
    final remoteConfig = FirebaseRemoteConfig.instance;
    const updateVersionKey = "update_version";
    final confVer = remoteConfig.getString(updateVersionKey);
    if (confVer.isEmpty) return false;

    final result = pkgVer.compareTo(confVer) < 0;
    return result;
  } catch (error) {
    return false;
  }
}

class MaterialAppClass extends ConsumerWidget {
  const MaterialAppClass({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
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
        // fontFamily: 'ZenMaruGothic',
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
        //scaffoldBackgroundColor: const Color(0xFFE5E5E5),
        useMaterial3: true,
      ),
      home: const ControlPage(),
    );
  }
}

class ControlPage extends ConsumerStatefulWidget{
  const ControlPage({super.key});

  @override
  ConsumerState<ControlPage> createState() => ControlPageState();
}

class ControlPageState extends ConsumerState<ControlPage>{
  @override
  void initState() {
    super.initState();
    final packageInfo = ref.read(packageInfoProvider);
    final remoteConfig = FirebaseRemoteConfig.instance;
    // リアルタイムで変更を監視
    remoteConfig.onConfigUpdated.listen((event) async {
      try {
        await remoteConfig.activate();
        bool update = checkForceUpdate(packageInfo!.version);

        if(update) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            _showDialog(context);
          });
        }
      } catch (error) {
        // エラーが発生したら、なにもしない
      }
    });

    remoteConfig.fetch();
    bool update = checkForceUpdate(packageInfo!.version);

    if(update) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _showDialog(context);
      });
    }
  }

  @override
  Widget build(BuildContext context){
    final authState = ref.watch(authStateChangeProvider);
    return authState.when(
        data: (data) {
          if(data != null) {
            return const TopPage();
          }else{
            return const LoginPage();
          }
        },
        loading: () => Container(),
        error: (_, __) => Container()
    );
  }
}

class TopPage extends ConsumerStatefulWidget{
  const TopPage({super.key});

  @override
  ConsumerState createState() => TopPageState();
}

class TopPageState extends ConsumerState{
  late final TabValue? tabValue;
  int number = 0;
  TabItem _currentTab = TabItem.search;

  final Map<TabItem, GlobalKey<NavigatorState>> _navigatorKeys = {
    TabItem.search: GlobalKey<NavigatorState>(),
    TabItem.calendar: GlobalKey<NavigatorState>(),
    TabItem.myCalendar: GlobalKey<NavigatorState>(),
  };

  @override
  void initState() {
    super.initState();

    tabValue = ref.read(tabValueProvider);
    if(tabValue != null){
      number = tabValue!.tabIndex!;
      if(number == 0){
        _currentTab = TabItem.search;
      }else if(number == 1){
        _currentTab = TabItem.calendar;
      }else{
        _currentTab = TabItem.myCalendar;
      }
    }

    // 通知をタップした時の処理
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message){
      Payload payload = Payload.fromJson(message.data);
      if(message.data.isNotEmpty) {
        FirebaseFirestore.instance
            .collection('calendar')
            .doc(payload.calendarId)
            .get().then((snapshot) {
              if (snapshot.exists) {
                number = 1;
                onSelect(TabItem.values[1]);
                var calendar = Calendar.fromJson(snapshot.data()!);
                var calendarDoc = CalendarDocument(docId: snapshot.id, calendar: calendar);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        FollowCalendarPage(calendarDoc, true),
                  ),
                );
              } else {
                number = 2;
                onSelect(TabItem.values[2]);
                ref.read(calendarFormatState.notifier).state = CalendarFormat.twoWeeks;
              }
            });
          }
    });
  }

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
        onTap: (index) async {
          if (tabValue != null) {
            await ref.read(tabValueRepositories).updateTabIndex(tabValue!, index);
          }
          number = index;
          onSelect(TabItem.values[index]);
        },
      ),
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