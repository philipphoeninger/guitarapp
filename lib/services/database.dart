import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:guitar_app/screens/song.dart';

class DatabaseService {

  // collection reference
  final CollectionReference songCollection = FirebaseFirestore.instance.collection('songs');

  /*static Future<Song> createSong(Song song) async {
    return Future();
  }*/
}
