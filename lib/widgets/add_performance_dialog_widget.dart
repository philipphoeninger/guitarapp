import 'package:flutter/material.dart';
import 'package:guitar_app/providers/performances.dart';
import 'package:guitar_app/widgets/performance_form_widget.dart';
import 'package:guitar_app/models/performance.dart';
import 'package:provider/provider.dart';
import 'package:guitar_app/utils.dart';

class AddPerformanceDialogWidget extends StatefulWidget {
  @override
  _AddTodoDialogWidgetState createState() => _AddTodoDialogWidgetState();
}

class _AddTodoDialogWidgetState extends State<AddPerformanceDialogWidget> {
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
            'Auftritt erstellen',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          ),
          const SizedBox(height: 8),
          PerformanceFormWidget(
            onChangedTitle: (title) => setState(() => this.title = title),
            onChangedDescription: (description) =>
                setState(() => this.description = description),
            onSavedPerformance: addPerformance,
          ),
        ],
      ),
    ),
  );

  Future<void> addPerformance() async {
    final isValid = _formKey.currentState!.validate();
    if (!isValid) {
      return;
    } else {
      final performance = Performance(
        id: DateTime.now().toString(),
        title: title,
        description: description,
        createdTime: DateTime.now(),
      );

      final provider = Provider.of<PerformancesProvider>(context, listen: false);
      await provider.addPerformance(performance);

      Navigator.of(context).pop();
      Utils.showSnackBar(context, 'Auftritt erstellt');
    }
  }
}