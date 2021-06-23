import 'package:flutter/material.dart';
import 'package:guitar_app/models/part.dart';
import 'package:guitar_app/models/song.dart';
import 'package:guitar_app/widgets/part/cards/part_card_song.dart';

class PartListWidget extends StatelessWidget {
  late final List<Part> parts;
  late final Song song;

  PartListWidget(this.parts, this.song);

  @override
  Widget build(BuildContext context) {
    return this.parts.isEmpty
        ? Center(
            child: Text(
              'Keine Parts',
              style: TextStyle(fontSize: 20),
            ),
          )
        : ListView.separated(
            physics: BouncingScrollPhysics(),
            padding: EdgeInsets.all(16),
            separatorBuilder: (context, index) => Container(height: 8),
            itemCount: this.parts.length,
            itemBuilder: (context, index) {
              final part = this.parts[index];
              return PartCardSong(part: part, song: song);
            });
  }
}
