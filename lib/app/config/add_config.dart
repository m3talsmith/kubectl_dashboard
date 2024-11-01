import 'package:flutter/material.dart';
import 'package:kubeconfig/kubeconfig.dart';
import 'package:kubectl_dashboard/app/config.dart';

class AddConfigForm extends StatefulWidget {
  const AddConfigForm({super.key});

  @override
  State<StatefulWidget> createState() => _AddConfigFormState();
}

class _AddConfigFormState extends State<AddConfigForm> {
  String data = '';

  bool valid() {
    try {
      return Kubeconfig.fromYaml(data).validate().code == ValidationCode.valid;
    } catch (_) {
      return false;
    }
  }

  submit(BuildContext context) {
    if (valid()) {
      final config = Config.fromYaml(data);
      Navigator.pop(context, config);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
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
              child: ElevatedButton(onPressed: () {
                submit(context);
              }, child: const Text('Add Config')),
            )
          ],
        ),
      ),
    );
  }
}
