import 'package:flutter/material.dart';
import 'package:kubectl_dashboard/app/dashboard/resources/resource_form.dart';

class ResourceAdd extends StatelessWidget {
  const ResourceAdd({required this.kind, super.key});

  final String kind;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add $kind'),
        centerTitle: true,
      ),
      body: ResourceForm(
        kind: kind,
      ),
    );
  }
}
