import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:guitar_app/song/song_model/song_model.dart';
import 'package:guitar_app/song/song_service/songs_provider.dart';
import 'package:guitar_app/song/song_edit/edit_song.dart';
import 'package:provider/provider.dart';
import 'package:guitar_app/shared/utils.dart';
import 'package:guitar_app/song/song_screen.dart';

class SongCardSongs extends StatelessWidget {
  final Song song;

  const SongCardSongs({required this.song, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Slidable(
            actionPane: SlidableDrawerActionPane(),
            key: Key(song.id),
            actions: [
              IconSlideAction(
                icon: Icons.edit,
                color: Colors.green,
                caption: 'bearbeiten',
                onTap: () => editSong(context, song),
              )
            ],
            secondaryActions: [
              IconSlideAction(
                icon: Icons.delete,
                color: Colors.red,
                caption: 'Löschen',
                onTap: () => deleteSong(context, song),
              )
            ],
            child: buildSong(context)),
      );

  Widget buildSong(BuildContext context) => GestureDetector(
        onTap: () => Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => SongScreen(song: song)),
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
                  song.title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.blue[500],
                  ),
                ),
                if (song.description.isNotEmpty)
                  Container(
                    margin: EdgeInsets.only(top: 0),
                    child: Text(song.description,
                        style: TextStyle(fontSize: 18, height: 1.5)),
                  ),
              ],
            ))
          ]),
        ),
      );

  Future<void> deleteSong(BuildContext context, Song song) async {
    final provider = Provider.of<SongsProvider>(context, listen: false);
    await provider.removeSong(song);

    Utils.showSnackBar(context, 'Song gelöscht');
  }

  void editSong(BuildContext context, Song song) => Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => EditSong(song: song)),
      );
}
