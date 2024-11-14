import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kubectl_dashboard/app/config/providers.dart';

import '../config.dart';

final dataProvider = StateProvider<String?>((ref) => null);

class ConfigForm extends ConsumerStatefulWidget {
  const ConfigForm({this.data, super.key});

  final String? data;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ConfigFormState();
}

class _ConfigFormState extends ConsumerState<ConfigForm> {
  String? data;
  Config? widgetConfig;

  submit(BuildContext context) async {
    var configs = ref.watch(configsProvider);
    configs ??= [];
    final nav = Navigator.of(context);

    if (data != null && data!.isNotEmpty) {
      final config = Config.fromYaml(data!);
      if (config == null) return;

      var index = configs.length-1;

      if (widgetConfig != null) {
        if (configs.contains(widgetConfig!)) {
          index = configs.indexOf(widgetConfig!);
          configs[index] = config;
        }
      } else {
        configs.add(config);
      }
      ref.watch(currentConfigIndexProvider.notifier).state = index;
      ref.watch(configsProvider.notifier).state = configs;
      ref.watch(currentConfigProvider.notifier).state = config;
      await saveConfigs(configs);
      nav.pop();
    }
  }

  @override
  void initState() {
    super.initState();

    data = widget.data;
    if (data != null && data!.isNotEmpty) {;
      final config = Config.fromYaml(data!);
      if (config != null) widgetConfig = config;
    }
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
                onPressed: () async {
                  await submit(context);
                },
                child: const Text('Save Config')),
          )
        ],
      ),
    );
  }

}
