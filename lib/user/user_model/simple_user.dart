import 'package:guitar_app/shared/utils.dart';

class SimpleUser {
  String uid;
  String imagePath;
  String email;
  String fullName;
  String description;
  DateTime createdTime;

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
