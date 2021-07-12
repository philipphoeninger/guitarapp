import 'package:flutter/material.dart';
import 'package:guitar_app/settings/menu_item.dart';
import 'package:guitar_app/user/user_model/simple_user.dart';
import 'package:guitar_app/song/song_model/song_model.dart';
import 'package:guitar_app/song/song_service/songs_provider.dart';
import 'package:guitar_app/database_api/database.dart';
import 'package:guitar_app/settings/settings_menu.dart';
import 'package:guitar_app/shared/constants.dart';
import 'package:guitar_app/shared/search_widget.dart';
import 'package:guitar_app/song/song_edit/add_song_dialog_widget.dart';
import 'package:guitar_app/song/song_list/song_list_widget.dart';
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
            stream: DatabaseService.readSongs(Provider.of<SimpleUser?>(context)!),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return Center(child: CircularProgressIndicator());
                default:
                  if (snapshot.hasError) {
                    print(snapshot.error);
                    return buildText('Etwas ist schiefgelaufen...');
                  } else {
                    final songs = snapshot.data;
                    final provider = Provider.of<SongsProvider>(context);
                    provider.setSongs(songs!);
                    this.songs = songs;
                    var filteredSongs = this.songs.where(containsSearchQuery).toList();

                    return Expanded(
                      child: SongListWidget(filteredSongs),
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
        onChanged: (text) => setState(() => this.query = text),
      );

  bool containsSearchQuery(Song song) {
    final titleLower = song.title.toLowerCase();
    final descriptionLower = song.description.toLowerCase();
    final searchLower = query.toLowerCase();

      return titleLower.contains(searchLower) ||
          descriptionLower.contains(searchLower);
  }

  Widget buildText(String text) => Center(
        child: Text(
          text,
          style: TextStyle(fontSize: 24, color: Colors.black),
        ),
      );
}
