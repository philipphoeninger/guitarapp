import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:guitar_app/services/auth.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Einstellungen'),
        centerTitle: true,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 1.0,
      ),
      body: Container(
        padding: EdgeInsets.only(left: 16, top: 25, right: 16),
        child: ListView(
          children: [
            SizedBox(height: 4),
            Row(
              children: [
                Icon(Icons.person, color: Colors.green[300]),
                SizedBox(width: 8),
                Text(
                  'Account',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ],
            ),
            Divider(height: 15, thickness: 1, color: Colors.grey),
            SizedBox(height: 10),
            buildAccountOptionRow(context, 'Passwort ändern'),
            buildAccountOptionRow(context, 'Sprache'),
            buildAccountOptionRow(context, 'Privatsphäre und Sicherheit'),
            SizedBox(height: 30),
            Row(
              children: [
                Icon(Icons.person, color: Colors.green[300]),
                SizedBox(width: 8),
                Text(
                  'Benachrichtigungen',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ],
            ),
            Divider(height: 15, thickness: 1, color: Colors.grey),
            SizedBox(height: 10),
            buildNotificationOptionRow('Neu für dich', true),
            buildNotificationOptionRow('Account Aktivitäten', false),
            buildNotificationOptionRow('Angebote', false),
            SizedBox(height: 50),
            Center(
              child: OutlinedButton(
                onPressed: () async {
                  await _authService.signOut();
                },
                child: Text('Logout',
                    style: TextStyle(
                        fontSize: 16, letterSpacing: 2.2, color: Colors.black)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  GestureDetector buildAccountOptionRow(BuildContext context, String label) {
    return GestureDetector(
      onTap: () {
        // ...
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.normal,
                color: Colors.grey[700],
              ),
            ),
            Icon(Icons.arrow_forward, color: Colors.grey)
          ],
        ),
      ),
    );
  }

  Row buildNotificationOptionRow(String label, bool isActive) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.normal,
              color: Colors.grey[600]),
        ),
        Switch(value: isActive, onChanged: (bool val) {}),
      ],
    );
  }
}
