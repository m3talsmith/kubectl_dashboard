import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kubectl_dashboard/app/config.dart';
import 'package:kubectl_dashboard/app/config/config_form.dart';
import 'package:kubectl_dashboard/app/config/providers.dart';

class EditConfig extends ConsumerWidget {
  const EditConfig({required this.index, super.key});

  final int index;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Config config = ref.watch(configsProvider)![index];
    final data = config.toString();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Kubeconf'),
        centerTitle: true,
      ),
      body: ConfigForm(data: data,),
    );
  }
}


