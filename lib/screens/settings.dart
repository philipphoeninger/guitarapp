import 'package:flutter/material.dart';

class Settings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[50],
      appBar: AppBar(
        title: Text('Einstellungen'),
        centerTitle: true,
        backgroundColor: Colors.pink[400],
        elevation: 0.0,
      ),
    );
  }
}
