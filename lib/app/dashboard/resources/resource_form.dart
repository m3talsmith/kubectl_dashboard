import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kuberneteslib/kuberneteslib.dart';

class ResourceForm extends ConsumerStatefulWidget {
  const ResourceForm({super.key, this.resource});

  final Resource? resource;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ResourceFormState();
}

class _ResourceFormState extends ConsumerState<ResourceForm> {
  String? data;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}
