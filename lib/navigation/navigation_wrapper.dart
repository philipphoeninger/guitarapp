import 'package:flutter/material.dart';
import 'package:guitar_app/navigation/tab_navigator_widget.dart';

class NavigationWrapper extends StatefulWidget {

  @override
  _NavigationWrapperState createState() => _NavigationWrapperState();
}

class _NavigationWrapperState extends State<NavigationWrapper> {
  String _currentPage = "Home";
  List<String> pageKeys = ["Home", "Songs", "Performances"];
  Map<String, GlobalKey<NavigatorState>> _navigatorKeys = {
    "Home": GlobalKey<NavigatorState>(),
    "Songs": GlobalKey<NavigatorState>(),
    "Performances": GlobalKey<NavigatorState>(),
  };
  int _selectedIndex = 0;

  void _selectTab(String tabItem, int index) {
    if(tabItem == _currentPage ){
      _navigatorKeys[tabItem]!.currentState!.popUntil((route) => route.isFirst);
    } else {
      setState(() {
        _currentPage = pageKeys[index];
        _selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(child: Scaffold(
      body: Stack(
        children: [
          _buildOffstageNavigator(tabItem: "Home"),
          _buildOffstageNavigator(tabItem: "Songs"),
          _buildOffstageNavigator(tabItem: "Performances"),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.blueAccent,
        onTap: (int index) { _selectTab(pageKeys[index], index); },
        currentIndex: _selectedIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.music_note_rounded),
            label: 'Songs',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people_outline_rounded),
            label: 'Auftritte',
          )
        ],
        type: BottomNavigationBarType.fixed,
      ),
    ), onWillPop: () async {
      final isFirstRouteInCurrentTab = !await _navigatorKeys[_currentPage]!.currentState!.maybePop();
      if (isFirstRouteInCurrentTab) {
        if (_currentPage != "Home") {
          _selectTab("Home", 1);
          return false;
        }
      }
      // let system handle back button if we're on the first route
      return isFirstRouteInCurrentTab;
    });
  }

  Widget _buildOffstageNavigator({required String tabItem }) {
    return Offstage(
      offstage: _currentPage != tabItem,
      child: TabNavigatorWidget(_navigatorKeys[tabItem]!, tabItem),
    );
  }
}
