import 'package:flutter/material.dart';

class AccountStatistics extends StatelessWidget {
  @override
  Widget build(BuildContext context) => IntrinsicHeight(
    child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buildButton(context, '12', 'Songs'),
            buildDivider(),
            buildButton(context, '31', 'Parts'),
            buildDivider(),
            buildButton(context, '4', 'Auftritte'),
          ],
        ),
  );

  Widget buildButton(BuildContext context, String value, String label) =>
      MaterialButton(
        padding: EdgeInsets.symmetric(vertical: 4),
        onPressed: () {},
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              value,
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
