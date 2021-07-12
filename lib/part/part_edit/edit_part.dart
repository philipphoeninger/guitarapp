import 'package:flutter/material.dart';
import 'package:guitar_app/part/part_model/part_model.dart';
import 'package:guitar_app/song/song_model/song_model.dart';
import 'package:guitar_app/part/part_service/parts_provider.dart';
import 'package:guitar_app/shared/utils.dart';
import 'package:guitar_app/part/part_edit/part_form_widget.dart';
import 'package:provider/provider.dart';

class EditPart extends StatefulWidget {
  final Part part;
  final Song song;

  const EditPart({Key? key, required this.part, required this.song})
      : super(key: key);

  @override
  _EditPartState createState() => _EditPartState();
}

class _EditPartState extends State<EditPart> {
  final _formKey = GlobalKey<FormState>();

  late String title;
  late String notes;

  @override
  void initState() {
    super.initState();

    title = widget.part.title;
    notes = widget.part.notes;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Part bearbeiten'),
        backgroundColor: Colors.blue[400],
        elevation: 0.0,
        actions: [
          IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                final provider =
                    Provider.of<PartsProvider>(context, listen: false);
                provider.removePart(widget.part, widget.song);
                Navigator.of(context).pop();
                Utils.showSnackBar(context, 'Part gelöscht');
              })
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: PartFormWidget(
            title: title,
            notes: notes,
            onChangedTitle: (title) => setState(() => this.title = title),
            onChangedNotes: (notes) => setState(() => this.notes = notes),
            onSavedPart: savePart,
          ),
        ),
      ),
    );
  }

  Future<void> savePart() async {
    final isValid = _formKey.currentState!.validate();

    if (!isValid) {
      return;
    } else {
      final provider = Provider.of<PartsProvider>(context, listen: false);

      await provider.updatePart(widget.part, widget.song, title, notes);
      Utils.showSnackBar(context, 'Part bearbeitet');
      Navigator.of(context).pop();
    }
  }
}
