import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:guitar_app/performance/performance_model/performance_model.dart';
import 'package:guitar_app/database_api/database.dart';

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

  Future<String> removePerformance(Performance performance) =>
      DatabaseService.deletePerformance(performance);

  Future<String> updatePerformance(
      Performance performance, String title, String description) {
    performance.title = title;
    performance.description = description;

    return DatabaseService.updatePerformance(performance);
  }
}
