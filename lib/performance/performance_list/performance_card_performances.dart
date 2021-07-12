import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:guitar_app/performance/performance_model/performance_model.dart';
import 'package:guitar_app/performance/performance_service/performances_provider.dart';
import 'package:guitar_app/performance/performance_edit/edit_performance.dart';
import 'package:guitar_app/performance/performance_screen.dart';
import 'package:provider/provider.dart';
import 'package:guitar_app/shared/utils.dart';

class PerformanceCardPerformances extends StatelessWidget {
  final Performance performance;

  const PerformanceCardPerformances({required this.performance, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) => ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Slidable(
            actionPane: SlidableDrawerActionPane(),
            key: Key(performance.id),
            actions: [
              if (performance.title.toLowerCase().trim() != 'unsortiert')
                IconSlideAction(
                  icon: Icons.edit,
                  color: Colors.green,
                  caption: 'bearbeiten',
                  onTap: () => editPerformance(context, performance),
                )
            ],
            secondaryActions: [
              if (performance.title.toLowerCase().trim() != 'unsortiert')
                IconSlideAction(
                  icon: Icons.delete,
                  color: Colors.red,
                  caption: 'Löschen',
                  onTap: () => deletePerformance(context, performance),
                )
            ],
            child: buildPerformance(context)),
      );

  Widget buildPerformance(BuildContext context) => GestureDetector(
    onTap: () => Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => PerformanceScreen(performance: performance)),
    ),
        child: Container(
          padding: EdgeInsets.all(20),
          color: Colors.white,
          child: Row(children: [
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  performance.title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.blue[500],
                  ),
                ),
                if (performance.description.isNotEmpty)
                  Container(
                    margin: EdgeInsets.only(top: 0),
                    child: Text(performance.description,
                        style: TextStyle(fontSize: 18, height: 1.5)),
                  ),
              ],
            ))
          ]),
        ),
      );

  Future<void> deletePerformance(
      BuildContext context, Performance performance) async {
    final provider = Provider.of<PerformancesProvider>(context, listen: false);
    await provider.removePerformance(performance);

    Utils.showSnackBar(context, 'Auftritt gelöscht');
  }

  void editPerformance(BuildContext context, Performance performance) =>
      Navigator.of(context).push(
        MaterialPageRoute(
            builder: (context) => EditPerformance(performance: performance)),
      );
}
