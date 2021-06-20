import 'package:guitar_app/utils.dart';

class PerformanceField {
  static const createdTime = 'createdTime';
}

class Performance {
  String id;
  String title;
  String description;
  DateTime createdTime;

  Performance(
      {required this.id,
      required this.title,
      required this.createdTime,
      this.description = ''});

  static Performance fromJson(Map<String, dynamic> json) => Performance(
        createdTime: Utils.toDateTime(json['createdTime']),
        title: json['title'],
        description: json['description'],
        id: json['id'],
      );

  Map<String, dynamic> toJson() => {
        'createdTime': Utils.fromDateTimeToJson(createdTime),
        'id': id,
        'title': title,
        'description': description,
      };
}
