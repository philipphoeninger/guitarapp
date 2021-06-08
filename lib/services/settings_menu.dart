import 'package:flutter/material.dart';
import 'package:guitar_app/models/menu_item.dart';
import 'package:guitar_app/screens/account.dart';
import 'package:guitar_app/screens/settings.dart';
import 'package:guitar_app/services/auth.dart';
import 'package:guitar_app/shared/constants.dart';

class SettingsMenuService {
  final AuthService _authService = AuthService();

  Future<void> onItemSelected(BuildContext context, MenuItem item) async {
    switch (item) {
      case itemProfile:
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Account()));
        break;
      case itemSettings:
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Settings()));
        break;
      case itemHelp:
        // link to repo
        break;
      case itemLogout:
        await _authService.signOut();
        break;
    }
  }

  PopupMenuItem<MenuItem> buildItem(MenuItem item) => PopupMenuItem<MenuItem>(
        value: item,
        child: Row(
          children: [
            Icon(item.icon, color: Colors.black, size: 20),
            const SizedBox(width: 12),
            Text(item.text)
          ],
        ),
      );
}
