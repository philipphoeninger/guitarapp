import 'package:flutter/material.dart';
import 'package:guitar_app/part/part_service/parts_provider.dart';
import 'package:guitar_app/song/song_service/songs_provider.dart';
import 'package:guitar_app/performance/performance_service/performances_provider.dart';
import 'package:provider/provider.dart';

class AccountStatistics extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    int songsCounter = Provider.of<SongsProvider>(context).songs.length;
    int performancesCounter =
        Provider.of<PerformancesProvider>(context).performances.length;
    int partsCounter = Provider.of<PartsProvider>(context).parts.length;

    return IntrinsicHeight(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          buildButton(context, songsCounter, 'Songs'),
          buildDivider(),
          buildButton(context, partsCounter, 'Parts'),
          buildDivider(),
          buildButton(context, performancesCounter, 'Auftritte'),
        ],
      ),
    );
  }

  Widget buildButton(BuildContext context, int value, String label) =>
      MaterialButton(
        padding: EdgeInsets.symmetric(vertical: 4),
        onPressed: () {},
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              value.toString(),
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),
            SizedBox(height: 2),
            Text(
              label,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      );

  Widget buildDivider() => Container(
        height: 24,
        child: VerticalDivider(),
      );
}
