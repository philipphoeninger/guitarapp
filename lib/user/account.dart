import 'package:flutter/material.dart';
import 'package:guitar_app/user/user_model/simple_user.dart';
import 'package:guitar_app/user/account_image.dart';
import 'package:guitar_app/user/account_statistics.dart';
import 'package:guitar_app/user/user_edit/edit_account.dart';

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
          ]),
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          const SizedBox(height: 38),
          getUserProfilePicture(),
          const SizedBox(height: 30),
          buildName(widget.user),
          const SizedBox(height: 30),
          AccountStatistics(),
          const SizedBox(height: 30),
          buildDescription(widget.user),
          const SizedBox(height: 30),
        ],
      ),
    );
  }

  Widget getUserProfilePicture() {
    String imagePath = widget.user.imagePath;
    if (imagePath.isEmpty) {
      return AccountImage(
          imagePath:
              'https://i.stack.imgur.com/l60Hf.png',
          onClicked: () {});
    } else {
      return AccountImage(
        imagePath: imagePath,
        onClicked: () {},
      );
    }
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
        MaterialPageRoute(builder: (context) => EditAccount(user: widget.user)),
      );
}
