import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:guitar_app/song/song_model/song_model.dart';
import 'package:guitar_app/database_api/database.dart';

class SongsProvider extends ChangeNotifier {
  List<Song> _songs = [];

  List<Song> get songs => _songs;

  Future<String> addSong(Song song) => DatabaseService.createSong(song);

  void setSongs(List<Song> songs) =>
      WidgetsBinding.instance!.addPostFrameCallback((_) {
        _songs = songs;
        notifyListeners();
      });

  Future<String> removeSong(Song song) => DatabaseService.deleteSong(song);

  Future<String> updateSong(Song song, String title, String description, List<String> performances) {
    song.title = title;
    song.description = description;
    song.performances = performances;

    return DatabaseService.updateSong(song);
  }
}
