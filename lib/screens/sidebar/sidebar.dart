import 'dart:async';

import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:guitar_app/screens/sidebar/menu_item.dart';
import 'package:rxdart/rxdart.dart';

class SideBar extends StatefulWidget {
  @override
  _SideBarState createState() => _SideBarState();
}

class _SideBarState extends State<SideBar>
    with SingleTickerProviderStateMixin<SideBar> {
  late AnimationController _animationController;
  late StreamController<bool> isOpenedStreamController;
  late Stream<bool> isOpenedStream;
  late StreamSink<bool> isOpenedSink;
  final _animationDuration = const Duration(milliseconds: 350);

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: _animationDuration);
    isOpenedStreamController = PublishSubject<bool>();
    isOpenedStream = isOpenedStreamController.stream;
    isOpenedSink = isOpenedStreamController.sink;
  }

  @override
  void dispose() {
    _animationController.dispose();
    isOpenedStreamController.close();
    isOpenedSink.close();
    super.dispose();
  }

  void onIconPressed() {
    final animationStatus = _animationController.status;
    final isAnimationCompleted = animationStatus == AnimationStatus.completed;

    if (isAnimationCompleted) {
      isOpenedSink.add(false);
      _animationController.reverse();
    } else {
      isOpenedSink.add(true);
      _animationController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return StreamBuilder<bool>(
      initialData: false,
      stream: isOpenedStream,
      builder: (context, isOpenedAsync) {
        return AnimatedPositioned(
          duration: _animationDuration,
          top: 0,
          bottom: 0,
          left: isOpenedAsync.data != null && isOpenedAsync.data == true
              ? 0
              : -screenWidth,
          right: isOpenedAsync.data != null && isOpenedAsync.data == true
              ? 0
              : screenWidth - 40,
          child: Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  color: Colors.blue[600],
                  child: Column(
                    children: [
                      SizedBox(
                        height: 60,
                      ),
                      ListTile(
                        title: Text(
                          'Max Mustermann',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.w800),
                        ),
                        subtitle: Text(
                          'max.mustermann@gmail.com',
                          style: TextStyle(
                              color: Colors.blue[400],
                              fontSize: 17,
                              fontWeight: FontWeight.w800),
                        ),
                        leading: CircleAvatar(
                          child: Icon(
                            Icons.perm_identity,
                            color: Colors.white,
                          ),
                          radius: 40,
                        ),
                      ),
                      Divider(
                        height: 64,
                        thickness: 0.5,
                        color: Colors.white.withOpacity(0.3),
                        indent: 32,
                        endIndent: 32,
                      ),
                      MenuItem(icon: Icons.home, title: 'Home'),
                      MenuItem(icon: Icons.my_library_music_rounded, title: 'Songs'),
                      Divider(
                        height: 64,
                        thickness: 0.5,
                        color: Colors.white.withOpacity(0.3),
                        indent: 32,
                        endIndent: 32,
                      ),
                      MenuItem(icon: Icons.person, title: 'My Account'),
                      MenuItem(icon: Icons.settings, title: 'Settings'),
                      MenuItem(icon: Icons.help, title: 'Help'),
                      MenuItem(icon: Icons.exit_to_app, title: 'Logout'),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment(0, -0.92),
                child: GestureDetector(
                  onTap: () {
                    onIconPressed();
                  },
                  child: ClipPath(
                    clipper: CustomMenuClipper(),
                    child: Container(
                      width: 40,
                      height: 50,
                      color: Colors.blue[400],
                      alignment: Alignment.center,
                      child: AnimatedIcon(
                        progress: _animationController.view,
                        icon: AnimatedIcons.menu_close,
                        color: Colors.black38,
                        size: 35,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class CustomMenuClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Paint paint = Paint();
    paint.color = Colors.white;

    final width = size.width;
    final height = size.height;

    Path path = Path();
    path.moveTo(0, 0);
    path.quadraticBezierTo(0, 8, 10, 16);
    path.quadraticBezierTo(width - 1, height / 2 - 20, width, height / 2);
    path.quadraticBezierTo(width + 1, height / 2 + 20, 10, height - 16);
    path.quadraticBezierTo(0, height - 8, 0, height);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
