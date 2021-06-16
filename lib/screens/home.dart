import 'package:flutter/material.dart';
import 'package:guitar_app/models/menu_item.dart';
import 'package:guitar_app/services/settings_menu.dart';
import 'package:guitar_app/shared/constants.dart';

class Home extends StatelessWidget {
  final SettingsMenuService _settingsMenuService = SettingsMenuService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: AppBar(
        title: Text('Home'),
        centerTitle: true,
        backgroundColor: Colors.blue[400],
        elevation: 0.0,
        actions: [
          PopupMenuButton<MenuItem>(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            onSelected: (item) =>
                _settingsMenuService.onItemSelected(context, item),
            itemBuilder: (context) => [
              ...itemsFirst.map(_settingsMenuService.buildItem).toList(),
              PopupMenuDivider(),
              ...itemsSecond.map(_settingsMenuService.buildItem).toList(),
            ],
          ),
        ],
      ),
    );
  }
}
