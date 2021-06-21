import 'package:flutter/material.dart';
import 'package:guitar_app/models/performance.dart';

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
        : ListView.builder(
            physics: BouncingScrollPhysics(),
            padding: EdgeInsets.all(16),
            itemCount: this.performances.length,
            itemBuilder: (context, index) {
              final performance = this.performances[index];
              return buildPerformance(performance);
            });
  }

  Widget buildPerformance(Performance performance) => ListTile(
        leading: Image.network(
          'https://images.unsplash.com/photo-1622673705547-2609427981ef?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80',
          fit: BoxFit.cover,
          width: 50,
          height: 50,
        ),
        title: Text(performance.title),
      );
}
