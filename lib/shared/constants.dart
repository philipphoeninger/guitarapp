import 'package:flutter/material.dart';

const textInputDecoration = InputDecoration(
  fillColor: Colors.white,
  filled: true,
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.white, width: 2.0),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.pink, width: 2.0),
  ),
);

// routes
const String AuthWrapperRoute = '/';
const String NavigationWrapperRoute = '/nav_wrapper';
const String HomeRoute = '/home';
const String PartRoute = '/part';
const String PartsRoute = '/parts';
const String PerformancesRoute = '/performances';
const String PerformanceRoute = '/performance';
const String SettingsRoute = '/settings';
const String SongRoute = '/song';
const String SongsRoute = '/songs';
const String AccountRoute = '/account';
