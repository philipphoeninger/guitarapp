class SimpleUser {
  final String uid;
  final String imagePath;
  final String email;
  final String fullName;
  final String description;

  SimpleUser({required this.uid, this.email = '', this.fullName = '', this.description = '', this.imagePath = ''});
}
