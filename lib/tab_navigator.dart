import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:share_calendar/src/features/calendar/presentation/list/calendar_list.dart';
import 'package:share_calendar/src/features/calendar/presentation/search/search_page.dart';
import 'package:share_calendar/src/features/calendar/presentation/search/search_top_page.dart';
import 'package:share_calendar/src/features/event/presentation/calendar.dart';

import 'main.dart';

class TabNavigator extends StatelessWidget {
  const TabNavigator({
    Key? key,
    required this.tabItem,
    required this.routerName,
    required this.navigationKey,
  }) : super(key: key);

  final TabItem tabItem;
  final String routerName;
  final GlobalKey<NavigatorState>? navigationKey;

  Map<String, Widget Function(BuildContext)> _routerBuilder(BuildContext context) => {
    '/search': (context) => const SearchTopPage(),
    '/list': (context) => const AllCalendarList(),
    '/calendar': (context) => const PersonalCalendarPage(),
  };

  @override
  Widget build(BuildContext context) {
    final routerBuilder = _routerBuilder(context);

    return Navigator(
      key: navigationKey,
      initialRoute: '/',
      onGenerateRoute: (settings) {
        return MaterialPageRoute<Widget>(
          builder: (context) {
            return routerBuilder[routerName]!(context);
          },
        );
      },
    );
  }
}
