import 'package:flutter/material.dart';
import 'package:guitar_app/screens/account.dart';
import 'package:guitar_app/screens/auth_wrapper.dart';
import 'package:guitar_app/screens/home.dart';

// import 'package:guitar_app/screens/navigation_wrapper.dart';
// import 'package:guitar_app/screens/part.dart';
// import 'package:guitar_app/screens/parts.dart';
import 'package:guitar_app/screens/performances.dart';
import 'package:guitar_app/screens/settings.dart';

// import 'package:guitar_app/screens/song.dart';
import 'package:guitar_app/screens/songs.dart';

// import 'package:guitar_app/screens/undefined.dart';
import 'package:guitar_app/shared/constants.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case AuthWrapperRoute:
      return MaterialPageRoute(builder: (context) => AuthWrapper());
    case NavigationWrapperRoute:
    // return MaterialPageRoute(builder: (context) => NavWrapper());
    case HomeRoute:
      return MaterialPageRoute(builder: (context) => Home());
    case SongsRoute:
      return MaterialPageRoute(builder: (context) => Songs());
    case PerformancesRoute:
      return MaterialPageRoute(builder: (context) => Performances());
    case SongRoute:
    // return MaterialPageRoute(builder: (context) => Song());
    case PartRoute:
    // return MaterialPageRoute(builder: (context) => Part());
    case PartsRoute:
    // return MaterialPageRoute(builder: (context) => Parts());
    case AccountRoute:
      return MaterialPageRoute(builder: (context) => Account());
    case SettingsRoute:
      return MaterialPageRoute(builder: (context) => Settings());
    default:
      return MaterialPageRoute(builder: (context) => Home());
    // return MaterialPageRoute(builder: (context) => Undefined(settings.name!));
  }
}
