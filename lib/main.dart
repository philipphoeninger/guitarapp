import 'package:flutter/material.dart';
import 'package:guitar_app/user/user_model/simple_user.dart';
import 'package:guitar_app/part/part_service/parts_provider.dart';
import 'package:guitar_app/performance/performance_service/performances_provider.dart';
import 'package:guitar_app/song/song_service/songs_provider.dart';
import 'package:guitar_app/authentication/auth_wrapper.dart';
import 'package:guitar_app/authentication/authentication_service/auth_service.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // Set default `_initialized` and `_error` state to false
  bool _initialized = false;
  bool _error = false;

  // Define an async function to initialize FlutterFire
  void initializeFlutterFire() async {
    try {
      // Wait for Firebase to initialize and set `_initialized` state to true
      await Firebase.initializeApp();
      setState(() {
        _initialized = true;
      });
    } catch (e) {
      // Set `_error` state to true if Firebase initialization fails
      setState(() {
        _error = true;
      });
    }
  }

  @override
  void initState() {
    initializeFlutterFire();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Show error message if initialization failed
    if (_error) {
      return Text('Initialization of App failed.');
    }

    // Show a loader until FlutterFire is initialized
    if (!_initialized) {
      return Container(
        color: Colors.white,
      );
    }

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => PerformancesProvider()),
        ChangeNotifierProvider(create: (context) => SongsProvider()),
        ChangeNotifierProvider(create: (context) => PartsProvider()),
      ],
      child: StreamProvider<SimpleUser?>.value(
        value: AuthService().user,
        initialData: null,
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            scaffoldBackgroundColor: Colors.white,
            primaryColor: Colors.white,
            dividerColor: Colors.black,
          ),
          home: AuthWrapper(),
        ),
      ),
    );
  }
}
