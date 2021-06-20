import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:guitar_app/models/performance.dart';
import 'package:guitar_app/utils.dart';

class DatabaseService {
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
}
