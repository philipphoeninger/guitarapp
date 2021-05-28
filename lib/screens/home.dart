import 'package:flutter/material.dart';
import 'package:guitar_app/services/auth.dart';

class Home extends StatelessWidget {
  final AuthService _authService = AuthService();
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    if (index == 1) {
      // Navigator.pushNamed(context, '/songs');
    } else if (index == 2) {
      // Navigator.pushNamed(context, '/performances');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: AppBar(
        title: Text('GuitarMaster'),
        centerTitle: true,
        backgroundColor: Colors.blue[400],
        elevation: 0.0,
        actions: [
          TextButton.icon(
            icon: Icon(Icons.person),
            label: Text('Logout', style: TextStyle(color: Colors.black45),),
            onPressed: () async {
              return await _authService.signOut();
            },
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all<Color>(Colors.black38),
            ),
          )
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.my_library_music_rounded),
            label: 'Meine Songs',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.emoji_people_rounded),
            label: 'Auftritte',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.red,
        onTap: _onItemTapped,
      ),
    );
  }
}
