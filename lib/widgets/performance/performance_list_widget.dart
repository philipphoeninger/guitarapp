import 'package:flutter/material.dart';
import 'package:guitar_app/models/performance.dart';
import 'package:guitar_app/widgets/performance/cards/performance_card_performances.dart';

class PerformanceListWidget extends StatelessWidget {
  late final List<Performance> performances;

  PerformanceListWidget(this.performances);

  @override
  Widget build(BuildContext context) {
    return this.performances.isEmpty
        ? Center(
            child: Text(
              'Keine Auftritte',
              style: TextStyle(fontSize: 20),
            ),
          )
        : ListView.separated(
            physics: BouncingScrollPhysics(),
            padding: EdgeInsets.all(16),
            separatorBuilder: (context, index) => Container(height: 8),
            itemCount: this.performances.length,
            itemBuilder: (context, index) {
              final performance = this.performances[index];
              return PerformanceCardPerformances(performance: performance);
            });
  }
}
