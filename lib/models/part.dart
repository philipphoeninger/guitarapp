import 'package:guitar_app/utils.dart';

class PartField {
  static const createdTime = 'createdTime';
}

class Part {
  String id;
  String title;
  String notes;
  DateTime createdTime;

  Part({
    required this.id,
    required this.title,
    required this.createdTime,
    required this.notes,
  });

  static Part fromJson(Map<String, dynamic> json) => Part(
        createdTime: Utils.toDateTime(json['createdTime']),
        title: json['title'].trim(),
        id: json['id'].trim(),
        notes: json['notes'],
      );

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'createdTime': Utils.fromDateTimeToJson(createdTime),
      'id': id.trim(),
      'title': title.trim(),
      'notes': notes,
    };
    return map;
  }
}
