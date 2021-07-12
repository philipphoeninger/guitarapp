import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:guitar_app/settings/menu_item.dart';
import 'package:guitar_app/user/account.dart';
import 'package:guitar_app/settings/help.dart';
import 'package:guitar_app/settings/settings_screen.dart';
import 'package:guitar_app/authentication/authentication_service/auth_service.dart';
import 'package:guitar_app/shared/constants.dart';
import 'package:provider/provider.dart';
import 'package:guitar_app/user/user_model/simple_user.dart';

class SettingsMenuService {
  final AuthService _authService = AuthService();

  Future<void> onItemSelected(BuildContext context, MenuItem item) async {
    switch (item) {
      case itemProfile:
        var simpleUserLocal = Provider.of<SimpleUser?>(context, listen: false);
        if (simpleUserLocal != null) {
          // get SimpleUser by uid of user
          var simpleUserSnapshot = await FirebaseFirestore.instance
              .collection('simple_users')
              .limit(1)
              .where('id', isEqualTo: simpleUserLocal.uid)
              .get();
          var user = SimpleUser.fromJson(simpleUserSnapshot.docs.first.data());
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Account(user: user)));
        }
        break;
      case itemSettings:
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => SettingsScreen()));
        break;
      case itemHelp:
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Help()));
        break;
      case itemAbout:
        showAboutDialog(
          context: context,
          applicationIcon: applicationIcon,
          applicationVersion: applicationVersion,
          applicationName: applicationName,
          applicationLegalese: applicationLegalese,
        );
        break;
      case itemLogout:
        await _authService.signOut();
        break;
    }
  }

  PopupMenuItem<MenuItem> buildItem(MenuItem item) => PopupMenuItem<MenuItem>(
      value: item,
      // child: Row(
      //   children: [
      //     Icon(item.icon, color: Colors.black, size: 20),
      //     const SizedBox(width: 12),
      //     Text(item.text)
      //   ],
      // ),
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        leading: Icon(item.icon, color: Colors.pink),
        title: Text(item.text),
      ));
}
