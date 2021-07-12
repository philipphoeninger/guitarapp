import 'package:flutter/material.dart';
import 'package:guitar_app/song/song_model/song_model.dart';
import 'package:guitar_app/part/part_service/parts_provider.dart';
import 'package:guitar_app/part/part_edit/part_form_widget.dart';
import 'package:guitar_app/part/part_model/part_model.dart';
import 'package:provider/provider.dart';
import 'package:guitar_app/shared/utils.dart';

class AddPartDialogWidget extends StatefulWidget {
  final Song song;

  AddPartDialogWidget({Key? key, required this.song}) : super(key: key);

  @override
  _AddPartDialogWidgetState createState() => _AddPartDialogWidgetState();
}

class _AddPartDialogWidgetState extends State<AddPartDialogWidget> {
  final _formKey = GlobalKey<FormState>();
  String title = '';
  String notes = '';

  @override
  Widget build(BuildContext context) => AlertDialog(
        content: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Part erstellen',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),
              const SizedBox(height: 8),
              PartFormWidget(
                onChangedTitle: (title) => setState(() => this.title = title),
                onChangedNotes: (notes) => setState(() => this.notes = notes),
                onSavedPart: addPart,
              ),
            ],
          ),
        ),
      );

  Future<void> addPart() async {
    final isValid = _formKey.currentState!.validate();
    if (!isValid) {
      return;
    } else {
      final part = Part(
        id: DateTime.now().toString(),
        title: title,
        notes: notes,
        createdTime: DateTime.now(),
      );

      final provider = Provider.of<PartsProvider>(context, listen: false);

      await provider.addPart(part, widget.song);
      Utils.showSnackBar(context, 'Part erstellt');
      Navigator.of(context).pop();
    }
  }
}
