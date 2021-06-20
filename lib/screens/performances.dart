import 'package:flutter/material.dart';
import 'package:guitar_app/models/menu_item.dart';
import 'package:guitar_app/services/settings_menu.dart';
import 'package:guitar_app/shared/constants.dart';
import 'package:guitar_app/models/performance.dart';
import 'package:guitar_app/widgets/add_performance_dialog_widget.dart';
import 'package:guitar_app/widgets/search_widget.dart';
import 'package:guitar_app/services/database.dart';
import 'package:guitar_app/widgets/performance_list_widget.dart';
import 'package:provider/provider.dart';
import 'package:guitar_app/providers/performances.dart';

class Performances extends StatefulWidget {
  @override
  _PerformancesState createState() => _PerformancesState();
}

class _PerformancesState extends State<Performances> {
  final SettingsMenuService _settingsMenuService = SettingsMenuService();
  late List<Performance> performances;
  String query = '';

  @override
  void initState() {
    super.initState();
    performances = [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: AppBar(
        title: Text('Meine Auftritte'),
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
      body: Column(children: [
        buildSearch(),
        StreamBuilder<List<Performance>>(
            stream: DatabaseService.readPerformances(),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return Center(child: CircularProgressIndicator());
                default:
                  if (snapshot.hasError) {
                    return buildText('Etwas ist schiefgelaufen...');
                  } else {
                    final performances = snapshot.data;
                    final provider = Provider.of<PerformancesProvider>(context);
                    provider.setPerformances(performances!);
                    this.performances = performances;

                    return Expanded(
                      child: PerformanceListWidget(this.performances),
                    );
                  }
              }
            }),
      ]),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Colors.green[400],
        onPressed: () => showDialog(
            context: context, builder: (_) => AddPerformanceDialogWidget()),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget buildSearch() => SearchWidget(
        text: query,
        hintText: 'Titel eines Auftritts',
        onChanged: searchPerformance,
      );

  void searchPerformance(String query) {
    var performances = this.performances.where((performance) {
      final titleLower = performance.title.toLowerCase();
      final descriptionLower = performance.description.toLowerCase();
      final searchLower = query.toLowerCase();

      return titleLower.contains(searchLower) ||
          descriptionLower.contains(searchLower);
    }).toList();

    setState(() {
      this.query = query;
      this.performances = performances;
    });
  }

  Widget buildText(String text) => Center(
        child: Text(
          text,
          style: TextStyle(fontSize: 24, color: Colors.white),
        ),
      );
}
