import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';

import 'account_image.dart';
import 'button_widget.dart';

class AccountFormWidget extends StatefulWidget {
  final String fullName;
  final String description;
  final String imagePath;
  final ValueChanged<String> onChangedFullName;
  final ValueChanged<String> onChangedDescription;
  final ValueChanged<String> onChangedImagePath;
  final Function(File?) onSavedSimpleUser;

  AccountFormWidget({
    Key? key,
    this.fullName = '',
    this.description = '',
    this.imagePath = '',
    required this.onChangedFullName,
    required this.onChangedDescription,
    required this.onChangedImagePath,
    required this.onSavedSimpleUser,
  }) : super(key: key);

  @override
  _AccountFormWidgetState createState() => _AccountFormWidgetState();
}

class _AccountFormWidgetState extends State<AccountFormWidget> {
  File? file;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          const SizedBox(height: 38),
          getUserProfilePicture(),
          const SizedBox(height: 8),
          // task != null ? buildUploadStatus(task!) : Container(),
          const SizedBox(height: 24),
          Text(
            'Name',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          SizedBox(height: 8),
          TextFormField(
            initialValue: widget.fullName,
            maxLines: 1,
            onChanged: widget.onChangedFullName,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
          const SizedBox(height: 24),
          // TextFieldWidget(
          //   label: 'Email',
          //   text: widget.user.email,
          //   onChanged: (email) {},
          // ),
          // const SizedBox(height: 24),
          Text(
            'Über mich',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          SizedBox(height: 8),
          TextFormField(
            initialValue: widget.description,
            maxLines: 5,
            onChanged: widget.onChangedDescription,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
          SizedBox(height: 24),
          ButtonWidget(
            text: 'Speichern',
            icon: Icons.save,
            onClicked: () {
              file != null
                  ? widget.onSavedSimpleUser(file)
                  : widget.onSavedSimpleUser(null);
            },
          )
        ],
      ),
    );
  }

  Widget getUserProfilePicture() {
    String imagePath = widget.imagePath;
    if (imagePath.isEmpty) {
      return AccountImage(
          imagePath:
              'https://www.startpage.com/av/proxy-image?piurl=https%3A%2F%2Fi.stack.imgur.com%2Fl60Hf.png&sp=1625495363Tf90ca34451b68834c2edf920891d446815e9ae7a27c1994dc66823149f877b4c',
          onClicked: selectFile);
    } else {
      return AccountImage(
        imagePath: imagePath,
        onClicked: selectFile,
      );
    }
  }

  Future selectFile() async {
    final result = await FilePicker.platform
        .pickFiles(allowMultiple: false, type: FileType.image);

    if (result == null) return;
    final path = result.files.single.path!;
    setState(() => file = File(path));
  }
}
