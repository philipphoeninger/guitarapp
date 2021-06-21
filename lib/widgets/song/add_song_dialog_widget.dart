import 'package:flutter/material.dart';
import 'package:guitar_app/providers/songs.dart';
import 'package:guitar_app/widgets/song/song_form_widget.dart';
import 'package:guitar_app/models/song.dart';
import 'package:provider/provider.dart';
import 'package:guitar_app/utils.dart';

class AddSongDialogWidget extends StatefulWidget {
  @override
  _AddSongDialogWidgetState createState() => _AddSongDialogWidgetState();
}

class _AddSongDialogWidgetState extends State<AddSongDialogWidget> {
  final _formKey = GlobalKey<FormState>();
  String title = '';
  String description = '';

  @override
  Widget build(BuildContext context) => AlertDialog(
    content: Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Song erstellen',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          ),
          const SizedBox(height: 8),
          SongFormWidget(
            onChangedTitle: (title) => setState(() => this.title = title),
            onChangedDescription: (description) =>
                setState(() => this.description = description),
            onSavedSong: addSong,
          ),
        ],
      ),
    ),
  );

  Future<void> addSong() async {
    final isValid = _formKey.currentState!.validate();
    if (!isValid) {
      return;
    } else {
      final song = Song(
        id: DateTime.now().toString(),
        title: title,
        description: description,
        createdTime: DateTime.now(),
      );

      final provider = Provider.of<SongsProvider>(context, listen: false);

      await provider.addSong(song);
      Utils.showSnackBar(context, 'Song erstellt');
      Navigator.of(context).pop();
    }
  }
}