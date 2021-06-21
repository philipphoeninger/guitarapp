import 'package:guitar_app/models/performance.dart';
import 'package:guitar_app/utils.dart';

class SongField {
  static const createdTime = 'createdTime';
}

class Song {
  String id;
  String title;
  String description;
  DateTime createdTime;
  List<Performance> performances = [];

  Song({
    required this.id,
    required this.title,
    required this.createdTime,
    this.description = '',
  });

  static Song fromJson(Map<String, dynamic> json) => Song(
        createdTime: Utils.toDateTime(json['createdTime']),
        title: json['title'].trim(),
        description: json['description'].trim(),
        id: json['id'].trim(),
      );

  Map<String, dynamic> toJson() {
    List<String> performancesIDs = [];
    for (Performance performance in performances) {
      performancesIDs.add(performance.id.trim());
    }
    Map<String, dynamic> map = {
      'createdTime': Utils.fromDateTimeToJson(createdTime),
      'id': id.trim(),
      'title': title.trim(),
      'description': description.trim(),
      'performances': performancesIDs,
    };
    return map;
  }
}
