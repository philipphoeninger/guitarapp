import 'package:flutter/material.dart';

class PartFormWidget extends StatelessWidget {
  final String title;
  final String notes;
  final ValueChanged<String> onChangedTitle;
  final ValueChanged<String> onChangedNotes;
  final VoidCallback onSavedPart;

  const PartFormWidget({
    Key? key,
    this.title = '',
    this.notes = '',
    required this.onChangedTitle,
    required this.onChangedNotes,
    required this.onSavedPart,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            buildTitle(),
            SizedBox(height: 8),
            buildNotes(),
            SizedBox(height: 32),
            buildButton(),
          ],
        ),
      );

  Widget buildTitle() => TextFormField(
        maxLines: 1,
        initialValue: title,
        onChanged: onChangedTitle,
        validator: (title) {
          if (title!.isEmpty) {
            return 'Der Titel darf nicht leer sein';
          }
          return null;
        },
        decoration: InputDecoration(
          border: UnderlineInputBorder(),
          labelText: 'Titel',
        ),
      );

  Widget buildNotes() => TextFormField(
        maxLines: 3,
        initialValue: notes,
        onChanged: onChangedNotes,
        decoration: InputDecoration(
          border: UnderlineInputBorder(),
          labelText: 'Notizen',
        ),
      );

  Widget buildButton() => SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.black),
          ),
          onPressed: onSavedPart,
          child: Text('Speichern'),
        ),
      );
}
