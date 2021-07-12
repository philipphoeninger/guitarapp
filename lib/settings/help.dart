import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class Help extends StatelessWidget {
  const Help({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hilfe'),
        centerTitle: true,
        backgroundColor: Colors.blue[400],
        elevation: 0.0,
      ),
      body: FutureBuilder(
        future: rootBundle.loadString('./README.md'),
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          if (snapshot.hasError) {
            return buildText('Etwas ist schiefgelaufen...');
          }
          if (snapshot.hasData) {
            var snapshotData = snapshot.data;
            if (snapshotData != null) {
              return Markdown(data: snapshotData);
            } else {
              return buildText('Hilfeseite hat keinen Inhalt');
            }

          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget buildText(String text) => Center(
    child: Text(
      text,
      style: TextStyle(fontSize: 24, color: Colors.black),
    ),
  );
}
