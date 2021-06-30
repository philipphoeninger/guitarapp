import 'package:flutter/material.dart';
import 'package:guitar_app/models/performance.dart';

class AddPerformancesToSongListTileWidget extends StatelessWidget {
  final Performance performance;
  final bool isSelected;
  final ValueChanged<Performance> onSelectedPerformance;

  const AddPerformancesToSongListTileWidget({
    Key? key,
    required this.performance,
    required this.isSelected,
    required this.onSelectedPerformance,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final selectedColor = Colors.green;
    final style = isSelected
        ? TextStyle(
            fontSize: 18, color: selectedColor, fontWeight: FontWeight.bold)
        : TextStyle(fontSize: 18);

    return ListTile(
      onTap: () => onSelectedPerformance(performance),
      title: Text(performance.title, style: style),
      trailing:
          isSelected ? Icon(Icons.check, color: selectedColor, size: 26) : null,
    );
  }
}
