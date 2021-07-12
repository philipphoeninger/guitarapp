import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:guitar_app/part/part_model/part_model.dart';
import 'package:guitar_app/song/song_model/song_model.dart';
import 'package:guitar_app/part/part_service/parts_provider.dart';
import 'package:guitar_app/part/part_edit/edit_part.dart';
import 'package:provider/provider.dart';
import 'package:guitar_app/shared/utils.dart';

class PartCardSong extends StatelessWidget {
  final Part part;
  final Song song;

  const PartCardSong({required this.part, required this.song, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) => ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Slidable(
            actionPane: SlidableDrawerActionPane(),
            key: Key(part.id),
            actions: [
              IconSlideAction(
                icon: Icons.edit,
                color: Colors.green,
                caption: 'bearbeiten',
                onTap: () => editPart(context, part, song),
              )
            ],
            secondaryActions: [
              IconSlideAction(
                icon: Icons.delete,
                color: Colors.red,
                caption: 'Löschen',
                onTap: () => deletePart(context, part),
              )
            ],
            child: buildPart(context)),
      );

  Widget buildPart(BuildContext context) => GestureDetector(
        onTap: () => editPart(context, part, song),
        child: Container(
          padding: EdgeInsets.all(20),
          color: Colors.white,
          child: Row(children: [
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  part.title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.blue[500],
                  ),
                ),
                if (part.notes.isNotEmpty)
                  Container(
                    margin: EdgeInsets.only(top: 0),
                    child: Text(part.notes,
                        style: TextStyle(fontSize: 18, height: 1.5)),
                  ),
              ],
            ))
          ]),
        ),
      );

  Future<void> deletePart(BuildContext context, Part part) async {
    final provider = Provider.of<PartsProvider>(context, listen: false);
    await provider.removePart(part, song);

    Utils.showSnackBar(context, 'Part gelöscht');
  }

  void editPart(BuildContext context, Part part, Song song) =>
      Navigator.of(context).push(
        MaterialPageRoute(
            builder: (context) => EditPart(part: part, song: song)),
      );
}
