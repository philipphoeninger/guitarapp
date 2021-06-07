import 'package:flutter/material.dart';
import 'package:guitar_app/screens/home.dart';
import 'package:guitar_app/screens/performances.dart';
import 'package:guitar_app/screens/songs.dart';

class TabNavigatorRoutes {
  // static const String auth_wrapper = '/';
  static const String home = '/home';
  static const String songs = '/songs';
  static const String performances = '/performances';
}

class TabNavigator extends StatefulWidget {
  final GlobalKey<NavigatorState> navigatorKey;
  final String tabItem;

  TabNavigator(this.navigatorKey, this.tabItem);

  @override
  _TabNavigatorState createState() => _TabNavigatorState();
}

class _TabNavigatorState extends State<TabNavigator> {
  @override
  Widget build(BuildContext context) {
    Widget child;
    if(widget.tabItem == "Home") {
      child = Home();
    }
    else if(widget.tabItem == "Songs") {
      child = Songs();
    }
    else {
      // if (tabItem == "Performances")
      child = Performances();
    }

    return Navigator(
      key: widget.navigatorKey,
      onGenerateRoute: (routeSettings) {
        return MaterialPageRoute(
          builder: (context) => child
        );
      },
    );
  }
}
