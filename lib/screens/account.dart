import 'package:flutter/material.dart';

class Account extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[50],
      appBar: AppBar(
        title: Text('Mein Profil'),
        centerTitle: true,
        backgroundColor: Colors.green[400],
        elevation: 0.0,
      ),
    );
  }
}
