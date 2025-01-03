import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kuberneteslib/kuberneteslib.dart' as k8s;

import 'config.dart';
import 'config/add_config.dart';
import 'config/config_list_tile.dart';
import 'config/edit_config.dart';
import 'config/providers.dart';

class AppDrawer extends ConsumerWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final configs = ref.watch(configsProvider);
    final currentConfig = ref.watch(currentConfigProvider);

    return Drawer(
      child: Column(
        children: [
          const Padding(padding: EdgeInsets.all(8)),
          Expanded(
            child: ListView(
              children: [
                if (configs.isNotEmpty)
                  ...configs.map((e) {
                    final index = configs.indexOf(e);
                    final selected = (currentConfig != null)
                        ? configs.indexOf(currentConfig)
                        : index;

                    onTap() {
                      ref.watch(currentConfigIndexProvider.notifier).state =
                          index;
                      Navigator.of(context).pop();
                    }

                    onEdit() async {
                      final configs = ref.watch(configsProvider);
                      final index =
                          (configs.isNotEmpty) ? configs.indexOf(e) : 0;
                      final navigator = Navigator.of(context);
                      await navigator.push(
                        MaterialPageRoute(
                          builder: (context) => EditConfig(
                            index: index,
                            config: configs[index],
                          ),
                        ),
                      );
                      navigator.pop();
                    }

                    onDelete() async {
                      ref
                          .watch(configsProvider.notifier)
                          .addListener(saveConfigs);
                      final index = ref.watch(configsProvider).indexOf(e);
                      ref.watch(configsProvider.notifier).state.removeAt(index);
                      final configs = ref.watch(configsProvider);
                      final configIndex = (configs.isNotEmpty)
                          ? configs.indexOf(configs.last)
                          : -1;

                      ref.watch(currentConfigIndexProvider.notifier).state =
                          index;

                      k8s.Config? config =
                          (configIndex >= 0) ? configs[configIndex] : null;
                      ref.watch(currentConfigProvider.notifier).state = config;

                      ref.invalidate(configsProvider);
                    }

                    return ConfigListTile(
                      index: index,
                      selected: selected,
                      onTap: onTap,
                      onEdit: onEdit,
                      onDelete: onDelete,
                    );
                  }),
              ],
            ),
          ),
          Container(
            color: Theme.of(context).primaryColor,
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: FilledButton.icon(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const AddConfig(),
                  ));
                },
                icon: const Icon(Icons.add),
                label: const Text('Add Cluster'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
