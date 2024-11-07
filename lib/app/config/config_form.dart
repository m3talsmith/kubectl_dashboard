import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../config.dart';

final dataProvider = StateProvider<String?>((ref) => null);

class ConfigForm extends StatefulWidget {
  const ConfigForm({this.data, super.key});

  final String? data;

  @override
  State<StatefulWidget> createState() => _ConfigFormState();
}

class _ConfigFormState extends State<ConfigForm> {
  String? data;

  submit(BuildContext context) {
    if (data != null && data!.isNotEmpty) {
      final config = Config.fromYaml(data!);
      Navigator.of(context).pop(config);
    }
  }

  @override
  void initState() {
    super.initState();
    data = widget.data;
  }

  @override
  Widget build(BuildContext context) {
    final undoController = UndoHistoryController();
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          Expanded(
            child: TextFormField(
              undoController: undoController,
              autofocus: true,
              initialValue: data,
              keyboardType: TextInputType.multiline,
              maxLines: null,
              expands: true,
              onChanged: (value) {
                setState(() {
                  data = value;
                });
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
                onPressed: () {
                  submit(context);
                },
                child: const Text('Save Config')),
          )
        ],
      ),
    );
  }

}
