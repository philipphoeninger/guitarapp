import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:guitar_app/models/performance.dart';
import 'package:guitar_app/services/database.dart';

class PerformancesProvider extends ChangeNotifier {
  List<Performance> _performances = [];

  List<Performance> get performances => _performances;

  Future<String> addPerformance(Performance performance) =>
      DatabaseService.createPerformance(performance);

  void setPerformances(List<Performance> performances) =>
      WidgetsBinding.instance!.addPostFrameCallback((_) {
        _performances = performances;
        notifyListeners();
      });
}
