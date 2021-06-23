import 'package:guitar_app/utils.dart';

class SongField {
  static const createdTime = 'createdTime';
}

class Song {
  String id;
  String title;
  String description;
  DateTime createdTime;
  List<String> performances;
  String user;

  Song({
    required this.id,
    required this.title,
    required this.createdTime,
    required this.performances,
    required this.user,
    this.description = '',
  });

  static Song fromJson(Map<String, dynamic> json) {
    List<String> performancesIDs = [];
    for (var performanceID in json['performances']) {
      performancesIDs.add(performanceID.toString());
    }

    return Song(
      createdTime: Utils.toDateTime(json['createdTime']),
      title: json['title'].trim(),
      description: json['description'].trim(),
      id: json['id'].trim(),
      user: json['user'].trim(),
      performances: performancesIDs,
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'createdTime': Utils.fromDateTimeToJson(createdTime),
      'id': id.trim(),
      'title': title.trim(),
      'description': description.trim(),
      'user': user.trim(),
      'performances': performances,
    };
    return map;
  }
}
