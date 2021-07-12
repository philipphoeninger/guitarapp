import 'package:flutter/material.dart';
import 'package:guitar_app/performance/performance_service/performances_provider.dart';
import 'package:guitar_app/performance/performance_edit/performance_form_widget.dart';
import 'package:guitar_app/performance/performance_model/performance_model.dart';
import 'package:provider/provider.dart';
import 'package:guitar_app/shared/utils.dart';
import 'package:guitar_app/user/user_model/simple_user.dart';

class AddPerformanceDialogWidget extends StatefulWidget {
  @override
  _AddPerformanceDialogWidgetState createState() =>
      _AddPerformanceDialogWidgetState();
}

class _AddPerformanceDialogWidgetState
    extends State<AddPerformanceDialogWidget> {
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
      final user = Provider.of<SimpleUser?>(context, listen: false);
      if (user != null) {
        final performance = Performance(
          id: DateTime.now().toString(),
          title: title,
          description: description,
          createdTime: DateTime.now(),
          user: user.uid,
        );

        final provider =
        Provider.of<PerformancesProvider>(context, listen: false);

        await provider.addPerformance(performance);
        Utils.showSnackBar(context, 'Auftritt erstellt');
        Navigator.of(context).pop();
      }
    }
  }
}
