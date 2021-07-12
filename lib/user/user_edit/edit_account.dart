import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:guitar_app/user/user_model/simple_user.dart';
import 'package:guitar_app/database_api/database.dart';
import 'package:path/path.dart' as path;

import '../../shared/utils.dart';
import '../account_form_widget.dart';

class EditAccount extends StatefulWidget {
  final SimpleUser user;

  const EditAccount({Key? key, required this.user}) : super(key: key);

  @override
  _EditAccountState createState() => _EditAccountState();
}

class _EditAccountState extends State<EditAccount> {
  UploadTask? task;
  File? file;
  late String fullName;
  late String description;
  late String imagePath;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    this.fullName = widget.user.fullName;
    this.description = widget.user.description;
    this.imagePath = widget.user.imagePath;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Account bearbeiten'),
        backgroundColor: Colors.blue[400],
        elevation: 0.0,
      ),
      body: Form(
        key: _formKey,
        child: AccountFormWidget(
            fullName: fullName,
            description: description,
            imagePath: imagePath,
            onChangedDescription: (description) =>
                setState(() => this.description = description),
            onChangedFullName: (fullName) =>
                setState(() => this.fullName = fullName),
            onChangedImagePath: (imagePath) =>
                setState(() => this.imagePath = imagePath),
            onSavedSimpleUser: (File? file) {
              saveSimpleUser(file);
            }),
      ),
    );
  }

  Future<void> saveSimpleUser(File? file) async {
    if (file != null) {
      final fileName = path.basename(file.path);
      final userId = widget.user.uid;
      final destination = 'profile_images/$userId/$fileName';

      task = DatabaseService.uploadFile(destination, file);
      setState(() {});

      if (task != null) {
        final snapshot = await task!.whenComplete(() => {});
        final urlDownload = await snapshot.ref.getDownloadURL();

        imagePath = urlDownload;
      }
    }

    await DatabaseService.updateSimpleUser(
        widget.user, fullName, description, imagePath);
    Utils.showSnackBar(context, 'Benutzer bearbeitet');
    Navigator.of(context).pop();
  }
}
