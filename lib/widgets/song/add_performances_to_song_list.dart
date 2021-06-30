import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:guitar_app/models/performance.dart';
import 'package:guitar_app/widgets/search_widget.dart';

import 'add_performances_to_song_list_tile_widget.dart';

class AddPerformancesToSongList extends StatefulWidget {
  final bool isMultiSelection;
  final List<Performance> allPerformances;
  final List<Performance> alreadySelectedPerformances;

  const AddPerformancesToSongList(
      {Key? key,
      this.isMultiSelection = false,
      this.allPerformances = const [],
      this.alreadySelectedPerformances = const []})
      : super(key: key);

  @override
  _AddPerformancesToSongListState createState() =>
      _AddPerformancesToSongListState();
}

class _AddPerformancesToSongListState extends State<AddPerformancesToSongList> {
  String searchText = '';
  List<Performance> selectedPerformances = [];

  @override
  void initState() {
    super.initState();
    this.selectedPerformances = widget.alreadySelectedPerformances;
  }

  @override
  Widget build(BuildContext context) {
    final filteredPerformances =
        widget.allPerformances.where(containsSearchText).toList();

    return Scaffold(
        appBar: AppBar(
          title: Text('Wähle Auftritte'),
          centerTitle: true,
          backgroundColor: Colors.blue[400],
          elevation: 0.0,
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(60),
            child: SearchWidget(
              text: searchText,
              hintText: 'Suche Auftritte',
              onChanged: (text) => setState(() => this.searchText = text),
            ),
          ),
        ),
        body: Column(
          children: <Widget>[
            Expanded(
              child: ListView(
                children: filteredPerformances.map<Widget>(
                  (performance) {
                    final isSelected =
                        selectedPerformances.contains(performance);

                    return AddPerformancesToSongListTileWidget(
                      performance: performance,
                      isSelected: isSelected,
                      onSelectedPerformance: selectPerformance,
                    );
                  },
                ).toList(),
              ),
            ),
            buildSelectButton(context),
          ],
        ));
  }

  Widget buildSelectButton(BuildContext context) {
    final label = widget.isMultiSelection
        ? selectedPerformances.length == 1
            ? 'Wähle ${selectedPerformances.length} Auftritt'
            : 'Wähle ${selectedPerformances.length} Auftritte'
        : 'Weiter';

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
      color: Colors.blue[400],
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: StadiumBorder(),
          minimumSize: Size.fromHeight(40),
          primary: Colors.white,
        ),
        child: Text(label, style: TextStyle(color: Colors.black, fontSize: 16)),
        onPressed: submit,
      ),
    );
  }

  bool containsSearchText(Performance performance) {
    final title = performance.title;
    final textLower = searchText.toLowerCase();
    final performanceLower = title.toLowerCase();
    return performanceLower.contains(textLower);
  }

  void selectPerformance(Performance performance) {
    if (widget.isMultiSelection) {
      final isSelected = this.selectedPerformances.contains(performance);
      setState(() => isSelected
          ? this.selectedPerformances.remove(performance)
          : this.selectedPerformances.add(performance));
    } else {
      Navigator.pop(context, performance);
    }
  }

  void submit() => Navigator.pop(context, selectedPerformances);

  Widget buildText(String text) => Center(
        child: Text(
          text,
          style: TextStyle(fontSize: 24, color: Colors.black),
        ),
      );
}
