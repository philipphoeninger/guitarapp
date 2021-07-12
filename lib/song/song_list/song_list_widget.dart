import 'package:flutter/material.dart';
import 'package:guitar_app/song/song_model/song_model.dart';
import 'package:guitar_app/song/song_list/song_card_songs.dart';

class SongListWidget extends StatelessWidget {
  late final List<Song> songs;

  SongListWidget(this.songs);

  @override
  Widget build(BuildContext context) {
    return this.songs.isEmpty
        ? Center(
            child: Text(
              'Keine Songs',
              style: TextStyle(fontSize: 20),
            ),
          )
        : ListView.separated(
            physics: BouncingScrollPhysics(),
            padding: EdgeInsets.all(16),
            separatorBuilder: (context, index) => Container(height: 8),
            itemCount: this.songs.length,
            itemBuilder: (context, index) {
              final song = this.songs[index];
              return SongCardSongs(song: song);
            });
  }
}
