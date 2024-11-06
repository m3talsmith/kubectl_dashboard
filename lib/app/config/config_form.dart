import 'package:flutter/material.dart';
import 'package:kubeconfig/kubeconfig.dart';

import '../config.dart';

class ConfigForm extends StatefulWidget {
  const ConfigForm({this.data, super.key});

  final String? data;

  @override
  State<StatefulWidget> createState() => _ConfigFormState();
}

class _ConfigFormState extends State<ConfigForm> {
  late String data;

  bool valid() {
    try {
      final code = Kubeconfig.fromYaml(data).validate().code;
      return code == ValidationCode.valid;
    } catch (e) {
      return false;
    }
  }

  submit(BuildContext context) {
    if (valid()) {
      final config = Config.fromYaml(data);
      Navigator.of(context).pop(config);
    }
  }

  @override
  @override
  void initState() {
    super.initState();
    data = widget.data ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          Expanded(
            child: TextField(
              autofocus: true,
              keyboardType: TextInputType.multiline,
              maxLines: null,
              expands: true,
              onChanged: (value) {
                setState(() {
                  data = value;
                });
              },
              onSubmitted: (_) {
                submit(context);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
                onPressed: () {
                  submit(context);
                },
                child: const Text('Add Config')),
          )
        ],
      ),
    );
  }
}