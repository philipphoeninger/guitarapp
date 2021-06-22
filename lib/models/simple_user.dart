import 'package:guitar_app/utils.dart';

class SimpleUser {
  final String uid;
  final String imagePath;
  final String email;
  final String fullName;
  final String description;
  final DateTime createdTime;

  SimpleUser({required this.uid, required this.createdTime, this.email = '', this.fullName = '', this.description = '', this.imagePath = ''});

  static SimpleUser fromJson(Map<String, dynamic> json) => SimpleUser(
    createdTime: Utils.toDateTime(json['createdTime']),
    uid: json['id'].trim(),
    description: json['description'].trim(),
    imagePath: json['imagePath'].trim(),
    email: json['email'].trim(),
    fullName: json['fullName'].trim(),
  );

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'createdTime': Utils.fromDateTimeToJson(createdTime),
      'id': uid.trim(),
      'imagePath': imagePath.trim(),
      'description': description.trim(),
      'fullName': fullName.trim(),
      'email': email.trim(),
    };
    return map;
  }
}
