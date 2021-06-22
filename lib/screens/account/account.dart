import 'package:flutter/material.dart';
import 'package:guitar_app/models/simple_user.dart';
import 'package:guitar_app/screens/account/account_image.dart';
import 'package:guitar_app/screens/account/account_statistics.dart';
import 'package:guitar_app/screens/account/edit_account.dart';

class Account extends StatefulWidget {
  final SimpleUser user;

  Account({required this.user});

  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.green[50],
      appBar: AppBar(
        title: Text('Mein Profil'),
        centerTitle: true,
        backgroundColor: Colors.green[400],
        elevation: 0.0,
        actions: [
          IconButton(
              icon: Icon(Icons.edit),
              onPressed: () => editAccount(context),
          )
        ]
      ),
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          const SizedBox(height: 38),
          AccountImage(
            imagePath: 'https://images.unsplash.com/photo-1622673705547-2609427981ef?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80',  // user!.imagePath,
            onClicked: () {},
          ),
          const SizedBox(height: 30),
          buildName(widget.user),
          const SizedBox(height: 30),
          AccountStatistics(),
          const SizedBox(height: 30),
          buildDescription(widget.user),
        ],
      ),
    );
  }

  Widget buildDefaultName() => Column(
    children: [
      Text(
        '<No Name Provided>',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
      )
    ],
  );

  Widget buildName(SimpleUser user) => Column(
    children: [
      Text(
        user.fullName,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
      ),
      const SizedBox(height: 4),
      Text(
        user.email,
        style: TextStyle(color: Colors.grey),
      )
    ],
  );

  Widget buildDescription(SimpleUser user) => Container(
    padding: EdgeInsets.symmetric(horizontal: 48),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Beschreibung',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        ),
        const SizedBox(height: 24),
        Text(
          user.description,
          style: TextStyle(fontSize: 16, height: 1.4),
        ),
      ],
    ),
  );

  void editAccount(BuildContext context) => Navigator.of(context).push(
    MaterialPageRoute(builder: (context) => EditAccount()),
  );
}
