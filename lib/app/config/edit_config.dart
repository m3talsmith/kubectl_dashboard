import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kubectl_dashboard/app/config/config_form.dart';
import 'package:kubectl_dashboard/app/config/providers.dart';
import 'package:kuberneteslib/kuberneteslib.dart';

class EditConfig extends ConsumerWidget {
  const EditConfig({required this.index, this.config, super.key});

  final int index;
  final Config? config;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Config config = ref.watch(configsProvider)[index];
    final data = config.toYaml();

    return Scaffold(
      appBar: AppBar(
        title: Text('Edit ${config.currentContext}'),
        centerTitle: true,
      ),
      body: ConfigForm(
        data: data,
        config: config,
      ),
    );
  }
}
