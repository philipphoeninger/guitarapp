import 'package:flutter/material.dart';
import 'package:guitar_app/user/user_model/simple_user.dart';
import 'package:guitar_app/performance/performance_model/performance_model.dart';
import 'package:guitar_app/database_api/database.dart';
import 'package:guitar_app/song/song_edit/add_performances_to_song_list.dart';
import 'package:provider/provider.dart';

class SongFormWidget extends StatefulWidget {
  final String title;
  final String description;
  final List<String> performances;
  final List<Performance> allPerformances;
  final ValueChanged<String> onChangedTitle;
  final ValueChanged<String> onChangedDescription;
  final ValueChanged<List<String>> onChangedPerformances;
  final VoidCallback onSavedSong;

  const SongFormWidget({
    Key? key,
    this.title = '',
    this.description = '',
    this.performances = const [],
    this.allPerformances = const [],
    required this.onChangedTitle,
    required this.onChangedDescription,
    required this.onChangedPerformances,
    required this.onSavedSong,
  }) : super(key: key);

  @override
  _SongFormWidgetState createState() => _SongFormWidgetState();
}

class _SongFormWidgetState extends State<SongFormWidget> {
  List<Performance> selectedPerformances = [];
  List<Performance> allPerformances = [];

  @override
  void initState() {
    super.initState();
    DatabaseService.getPerformances(
            Provider.of<SimpleUser?>(context, listen: false)!)
        .then((performances) {
      final unsortedPerformance = performances.singleWhere(
          (element) => element.title.toLowerCase() == 'unsortiert');
      performances.remove(unsortedPerformance);
      this.allPerformances = performances;
      this.selectedPerformances = this
          .allPerformances
          .where((performance) => widget.performances.contains(performance.id))
          .toList();
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            buildTitle(),
            SizedBox(height: 8),
            buildDescription(),
            SizedBox(height: 8),
            buildPerformances(context),
            SizedBox(height: 32),
            buildButton(),
          ],
        ),
      );

  Widget buildTitle() => TextFormField(
        maxLines: 1,
        initialValue: widget.title,
        onChanged: widget.onChangedTitle,
        validator: (title) {
          if (title!.isEmpty) {
            return 'Der Titel darf nicht leer sein';
          }
          return null;
        },
        decoration: InputDecoration(
          border: UnderlineInputBorder(),
          labelText: 'Titel',
        ),
      );

  Widget buildDescription() => TextFormField(
        maxLines: 3,
        initialValue: widget.description,
        onChanged: widget.onChangedDescription,
        decoration: InputDecoration(
          border: UnderlineInputBorder(),
          labelText: 'Beschreibung',
        ),
      );

  Widget buildPerformances(BuildContext context) {
    final performancesText =
        selectedPerformances.map((performance) => performance.title).join(', ');
    final onTap = () async {
      if (this.allPerformances.length == 0) {
        return;
      }
      final newlySelectedPerformances = await Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => AddPerformancesToSongList(
                  isMultiSelection: true,
                  allPerformances: this.allPerformances,
                  alreadySelectedPerformances:
                      List.of(this.selectedPerformances))));
      if (newlySelectedPerformances == null) {
        return;
      }

      setState(() => this.selectedPerformances = newlySelectedPerformances);
      widget.onChangedPerformances(
          selectedPerformances.map((performance) => performance.id).toList());
    };

    return this.selectedPerformances.isEmpty
        ? buildListTile(title: 'Kein Auftritt', onTap: onTap)
        : buildListTile(title: performancesText, onTap: onTap);
  }

  Widget buildListTile({required String title, required VoidCallback onTap}) =>
      ListTile(
        title: Text(
          title,
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(color: Colors.black, fontSize: 18),
        ),
        trailing: Icon(Icons.arrow_drop_down, color: Colors.black),
        onTap: onTap,
      );

  Widget buildButton() => SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.black),
          ),
          onPressed: widget.onSavedSong,
          child: Text('Speichern'),
        ),
      );
}
