import 'package:flutter/material.dart';
import 'package:guitar_app/services/auth.dart';


class Songs extends StatelessWidget {

  final AuthService _authService = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: AppBar(
        title: Text('Meine Songs'),
        centerTitle: true,
        backgroundColor: Colors.blue[400],
        elevation: 0.0,
        actions: [
          TextButton.icon(
            icon: Icon(Icons.person),
            label: Text('Logout'),
            onPressed: () async {
              return await _authService.signOut();
            },
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all<Color>(Colors.black38),
            ),
          )
        ],
      ),
    );
  }
}
