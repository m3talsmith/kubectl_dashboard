import 'package:flutter/material.dart';
import 'package:kubectl_dashboard/app/config/config_form.dart';

class AddConfig extends StatelessWidget {
  const AddConfig({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Kubeconf'),
        centerTitle: true,
      ),
      body: const ConfigForm(),
    );
  }
}


