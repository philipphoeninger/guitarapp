import 'package:flutter/material.dart';
import 'package:guitar_app/screens/home.dart';
import 'package:guitar_app/screens/sidebar/sidebar.dart';

class SideBarLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Home(),
          SideBar(),
        ],
      ),
    );
  }
}
