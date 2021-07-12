import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:guitar_app/part/part_model/part_model.dart';
import 'package:guitar_app/song/song_model/song_model.dart';
import 'package:guitar_app/database_api/database.dart';

class PartsProvider extends ChangeNotifier {
  List<Part> _parts = [];

  List<Part> get parts => _parts;

  Future<String> addPart(Part part, Song song) =>
      DatabaseService.createPart(part, song);

  void setParts(List<Part> parts) =>
      WidgetsBinding.instance!.addPostFrameCallback((_) {
        _parts = parts;
        notifyListeners();
      });

  Future<String> removePart(Part part, Song song) =>
      DatabaseService.deletePart(part, song);

  Future<String> updatePart(Part part, Song song, String title, String notes) {
    part.title = title;
    part.notes = notes;

    return DatabaseService.updatePart(part, song);
  }
}
