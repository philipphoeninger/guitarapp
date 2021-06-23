import 'package:guitar_app/utils.dart';

class PerformanceField {
  static const createdTime = 'createdTime';
}

class Performance {
  String id;
  String title;
  String description;
  DateTime createdTime;
  String user;

  Performance(
      {required this.id,
      required this.title,
      required this.createdTime,
      required this.user,
      this.description = ''});

  static Performance fromJson(Map<String, dynamic> json) => Performance(
        createdTime: Utils.toDateTime(json['createdTime']),
        title: json['title'].trim(),
        description: json['description'].trim(),
        id: json['id'].trim(),
        user: json['user'].trim(),
      );

  Map<String, dynamic> toJson() => {
        'createdTime': Utils.fromDateTimeToJson(createdTime),
        'id': id.trim(),
        'title': title.trim(),
        'description': description.trim(),
        'user': user.trim(),
      };
}
