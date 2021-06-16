import 'package:flutter/material.dart';
import 'package:guitar_app/models/menu_item.dart';

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

// menu items lists and menu items
const List<MenuItem> itemsFirst = [
  itemProfile,
  itemSettings,
  itemHelp,
  itemAbout,
];
const List<MenuItem> itemsSecond = [itemLogout];

const itemProfile = MenuItem(text: 'Mein Profil', icon: Icons.person);
const itemSettings = MenuItem(text: 'Einstellungen', icon: Icons.settings);
const itemHelp = MenuItem(text: 'Hilfe', icon: Icons.help);
const itemLogout = MenuItem(text: 'Logout', icon: Icons.logout);
const itemAbout = MenuItem(text: 'About', icon: Icons.business_rounded);

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
