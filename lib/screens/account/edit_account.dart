import 'package:flutter/material.dart';

class EditAccount extends StatefulWidget {
  const EditAccount({Key? key}) : super(key: key);

  @override
  _EditAccountState createState() => _EditAccountState();
}

class _EditAccountState extends State<EditAccount> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Account bearbeiten'),
        backgroundColor: Colors.blue[400],
        elevation: 0.0,
      ),
      body:
        Center(
          child: Text(
            'Diese Seite ist noch nicht verfügbar...',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
          )
        )
    );
  }
}
