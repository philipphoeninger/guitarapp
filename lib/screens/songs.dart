import 'package:flutter/material.dart';
import 'package:guitar_app/models/menu_item.dart';
import 'package:guitar_app/models/song.dart';
import 'package:guitar_app/providers/songs.dart';
import 'package:guitar_app/services/database.dart';
import 'package:guitar_app/services/settings_menu.dart';
import 'package:guitar_app/shared/constants.dart';
import 'package:guitar_app/widgets/search_widget.dart';
import 'package:guitar_app/widgets/song/add_song_dialog_widget.dart';
import 'package:guitar_app/widgets/song/song_list_widget.dart';
import 'package:provider/provider.dart';

class Songs extends StatefulWidget {
  @override
  _SongsState createState() => _SongsState();
}

class _SongsState extends State<Songs> {
  final SettingsMenuService _settingsMenuService = SettingsMenuService();
  late List<Song> songs;
  String query = '';

  @override
  void initState() {
    super.initState();
    songs = [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: AppBar(
        title: Text('Meine Songs'),
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
        StreamBuilder<List<Song>>(
            stream: DatabaseService.readSongs(),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return Center(child: CircularProgressIndicator());
                default:
                  if (snapshot.hasError) {
                    return buildText('Etwas ist schiefgelaufen...');
                  } else {
                    final songs = snapshot.data;
                    final provider = Provider.of<SongsProvider>(context);
                    provider.setSongs(songs!);
                    this.songs = songs;

                    return Expanded(
                      child: SongListWidget(this.songs),
                    );
                  }
              }
            }),
      ]),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Colors.green[400],
        onPressed: () =>
            showDialog(context: context, builder: (_) => AddSongDialogWidget()),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget buildSearch() => SearchWidget(
        text: query,
        hintText: 'Titel eines Songs',
        onChanged: searchSong,
      );

  void searchSong(String query) {
    var songs = this.songs.where((song) {
      final titleLower = song.title.toLowerCase();
      final descriptionLower = song.description.toLowerCase();
      final searchLower = query.toLowerCase();

      return titleLower.contains(searchLower) ||
          descriptionLower.contains(searchLower);
    }).toList();

    setState(() {
      this.query = query;
      this.songs = songs;
    });
  }

  Widget buildText(String text) => Center(
        child: Text(
          text,
          style: TextStyle(fontSize: 24, color: Colors.black),
        ),
      );
}
