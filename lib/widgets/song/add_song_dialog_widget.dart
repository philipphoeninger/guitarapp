import 'package:flutter/material.dart';
import 'package:guitar_app/providers/songs.dart';
import 'package:guitar_app/widgets/song/song_form_widget.dart';
import 'package:guitar_app/models/song.dart';
import 'package:provider/provider.dart';
import 'package:guitar_app/utils.dart';
import 'package:guitar_app/models/simple_user.dart';

class AddSongDialogWidget extends StatefulWidget {
  @override
  _AddSongDialogWidgetState createState() => _AddSongDialogWidgetState();
}

class _AddSongDialogWidgetState extends State<AddSongDialogWidget> {
  final _formKey = GlobalKey<FormState>();
  String title = '';
  String description = '';
  List<String> performances = [];

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
        child: AlertDialog(
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
                  onChangedPerformances: (List<String> performances) =>
                      setState(() => this.performances = performances),
                ),
              ],
            ),
          ),
        ),
      );

  Future<void> addSong() async {
    final isValid = _formKey.currentState!.validate();
    if (!isValid) {
      return;
    } else {
      final user = Provider.of<SimpleUser?>(context, listen: false);
      if (user != null) {
        final song = Song(
          id: DateTime.now().toString(),
          title: title,
          description: description,
          createdTime: DateTime.now(),
          user: user.uid,
          performances: performances,
        );

        final provider = Provider.of<SongsProvider>(context, listen: false);

        await provider.addSong(song);
        Utils.showSnackBar(context, 'Song erstellt');
        Navigator.of(context).pop();
      }
    }
  }
}
