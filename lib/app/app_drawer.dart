import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'config.dart';
import 'config/add_config.dart';
import 'config/config_list_tile.dart';
import 'config/providers.dart';

class AppDrawer extends ConsumerWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final configs = ref.watch(configsProvider);
    final currentConfigIndex = ref.watch(currentConfigIndexProvider);
    final Config? currentConfig = (configs != null && configs.isNotEmpty) ? configs[currentConfigIndex] : null;

    return Drawer(
      child: Column(
        children: [
          const Padding(padding: EdgeInsets.all(8)),
          Expanded(
            child: ListView(
              children: [
                if (configs != null)
                  ...configs.map((e) {
                    final index = configs.indexOf(e);
                    final selected = (currentConfig != null) ? configs.indexOf(currentConfig) : index;
                    onTap() {
                      ref.watch(currentConfigIndexProvider.notifier).state =
                          index;
                      Navigator.of(context).pop();
                    }
            
                    return ConfigListTile(
                      index: index,
                      selected: selected,
                      onTap: onTap,
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
                onPressed: () async {
                  ref.watch(configsProvider.notifier).addListener(saveConfigs);
                  final Config? config =
                  await Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const AddConfig(),
                  ));
                  if (config != null) {
                    final c = (configs == null) ? [config] : configs;
                    if (!c.contains(config)) {
                      c.add(config);
                    }
                    final index = c.length - 1;
                    ref.watch(currentConfigIndexProvider.notifier).state =
                        index;
                    ref.watch(configsProvider.notifier).state = c;
                  }
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
