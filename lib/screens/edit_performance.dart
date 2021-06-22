import 'package:flutter/material.dart';
import 'package:guitar_app/models/performance.dart';
import 'package:guitar_app/providers/performances.dart';
import 'package:guitar_app/widgets/performance/performance_form_widget.dart';
import 'package:provider/provider.dart';
import 'package:guitar_app/utils.dart';

class EditPerformance extends StatefulWidget {
  final Performance performance;

  const EditPerformance({Key? key, required this.performance})
      : super(key: key);

  @override
  _EditPerformanceState createState() => _EditPerformanceState();
}

class _EditPerformanceState extends State<EditPerformance> {
  final _formKey = GlobalKey<FormState>();

  late String title;
  late String description;

  @override
  void initState() {
    super.initState();

    title = widget.performance.title;
    description = widget.performance.description;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Auftritt bearbeiten'),
        backgroundColor: Colors.blue[400],
        elevation: 0.0,
        actions: [
          IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                final provider =
                    Provider.of<PerformancesProvider>(context, listen: false);
                provider.removePerformance(widget.performance);
                Navigator.of(context).pop();
                Utils.showSnackBar(context, 'Auftritt gelöscht');
              })
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: PerformanceFormWidget(
            title: title,
            description: description,
            onChangedTitle: (title) => setState(() => this.title = title),
            onChangedDescription: (description) =>
                setState(() => this.description = description),
            onSavedPerformance: savePerformance,
          ),
        ),
      ),
    );
  }

  Future<void> savePerformance() async {
    final isValid = _formKey.currentState!.validate();

    if (!isValid) {
      return;
    } else {
      final provider =
          Provider.of<PerformancesProvider>(context, listen: false);

      await provider.updatePerformance(widget.performance, title, description);
      Utils.showSnackBar(context, 'Auftritt bearbeitet');
      Navigator.of(context).pop();
    }
  }
}
