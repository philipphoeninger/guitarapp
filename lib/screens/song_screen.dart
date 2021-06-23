import 'package:flutter/material.dart';
import 'package:guitar_app/models/part.dart';
import 'package:guitar_app/models/song.dart';
import 'package:guitar_app/providers/parts.dart';
import 'package:guitar_app/screens/edit_song.dart';
import 'package:guitar_app/services/database.dart';
import 'package:guitar_app/widgets/part/add_part_dialog_widget.dart';
import 'package:guitar_app/widgets/part/part_list_widget.dart';
import 'package:provider/provider.dart';

class SongScreen extends StatefulWidget {
  final Song song;

  const SongScreen({Key? key, required this.song}) : super(key: key);

  @override
  _SongScreenState createState() => _SongScreenState();
}

class _SongScreenState extends State<SongScreen> {
  late List<Part> parts;

  @override
  void initState() {
    super.initState();
    parts = [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: AppBar(
        title: Text(widget.song.title),
        centerTitle: true,
        backgroundColor: Colors.blue[400],
        elevation: 0.0,
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () => editSong(context, widget.song),
          )
        ],
      ),
      body: Column(children: [
        StreamBuilder<List<Part>>(
            stream: DatabaseService.readParts(widget.song),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return Center(child: CircularProgressIndicator());
                default:
                  if (snapshot.hasError) {
                    print(snapshot.error);
                    return buildText('Etwas ist schiefgelaufen...');
                  } else {
                    final parts = snapshot.data;
                    final provider = Provider.of<PartsProvider>(context);
                    provider.setParts(parts!);
                    this.parts = parts;

                    return Expanded(
                      child: PartListWidget(this.parts, widget.song),
                    );
                  }
              }
            }),
      ]),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Colors.green[400],
        onPressed: () => showDialog(
            context: context,
            builder: (_) => AddPartDialogWidget(song: widget.song)),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  void editSong(BuildContext context, Song song) => Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => EditSong(song: song)),
      );

  Widget buildText(String text) => Center(
        child: Text(
          text,
          style: TextStyle(fontSize: 24, color: Colors.black),
        ),
      );
}
