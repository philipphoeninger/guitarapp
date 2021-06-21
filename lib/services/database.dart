import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:guitar_app/models/performance.dart';
import 'package:guitar_app/models/song.dart';
import 'package:guitar_app/utils.dart';

class DatabaseService {
  // Performance CRUD methods

  static Future<String> createPerformance(Performance performance) async {
    final docPerformance =
        FirebaseFirestore.instance.collection('performances').doc();
    performance.id = docPerformance.id;
    await docPerformance.set(performance.toJson());

    return docPerformance.id;
  }

  static Stream<List<Performance>> readPerformances() {
    Stream<QuerySnapshot> stream = FirebaseFirestore.instance
        .collection('performances')
        .orderBy(PerformanceField.createdTime, descending: true)
        .snapshots();

    return stream.map((event) => event.docs
        .map((doc) => Performance(
              id: doc['id'],
              title: doc['title'],
              createdTime: Utils.toDateTime(doc['createdTime']),
              description: doc['description'],
            ))
        .toList());
  }

  // Song CRUD methods

  static Future<String> createSong(Song song) async {
    // get "Unsortiert" performance & add it to Song
    var unsortedPerformanceSnapshot = await FirebaseFirestore.instance
        .collection('performances')
        .limit(1)
        .where('title', isEqualTo: 'Unsortiert')
        .get();
    var unsortedPerformance =
        Performance.fromJson(unsortedPerformanceSnapshot.docs.first.data());
    List<Performance> performances = [];
    performances.add(unsortedPerformance);

    song.performances = performances;

    // set Song ID and add Song to Firebase
    final docSong = FirebaseFirestore.instance.collection('songs').doc();
    song.id = docSong.id.trim();
    await docSong.set(song.toJson());

    return docSong.id;
  }

  static Stream<List<Song>> readSongs() {
    Stream<QuerySnapshot> stream = FirebaseFirestore.instance
        .collection('songs')
        .orderBy(SongField.createdTime, descending: true)
        .snapshots();

    return stream.map((event) => event.docs
        .map((doc) => Song(
              id: doc['id'],
              title: doc['title'],
              createdTime: Utils.toDateTime(doc['createdTime']),
              description: doc['description'],
            ))
        .toList());
  }

  static Future<String> updateSong(Song song) async {
    final docSong = FirebaseFirestore.instance.collection('songs').doc(song.id);
    await docSong.update(song.toJson());
    return docSong.id;
  }

  static Future<String> deleteSong(Song song) async {
    final docSong = FirebaseFirestore.instance.collection('songs').doc(song.id);
    await docSong.delete();
    return docSong.id;
  }
}
