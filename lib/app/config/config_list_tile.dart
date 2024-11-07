import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kubectl_dashboard/app/config/edit_config.dart';
import 'package:kubectl_dashboard/app/config/providers.dart';

import '../config.dart';

class ConfigListTile extends StatelessWidget {
  const ConfigListTile(
      {required this.config, this.selected, this.onTap, super.key});

  final Config config;
  final Config? selected;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    if (selected != null && config == selected!) {
      return Padding(
        padding: const EdgeInsets.only(right: 16.0),
        child: ListTile(
          onTap: onTap,
          title: Text(config.currentContext ?? 'unknown'),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(16),
              bottomRight: Radius.circular(16),
            ),
          ),
          tileColor: Theme.of(context).primaryColor,
          textColor: Theme.of(context).canvasColor,
          iconColor: Theme.of(context).canvasColor,
          leading: ConfigListTileMenu(
            config: config,
          ),
          trailing: const Icon(
            Icons.star_rounded,
          ),
        ),
      );
    }
    return Padding(
      padding: const EdgeInsets.only(right: 16.0),
      child: ListTile(
        onTap: onTap,
        title: Text(config.currentContext ?? 'unknown'),
        leading: ConfigListTileMenu(
          config: config,
        ),
      ),
    );
  }
}

class ConfigListTileMenu extends ConsumerWidget {
  const ConfigListTileMenu({required this.config, super.key});

  final Config config;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PopupMenuButton(
      itemBuilder: (context) {
        return [
          PopupMenuItem(
            onTap: () async {
              final index = ref.watch(configsProvider)!.indexOf(config);
              final navigator = Navigator.of(context);
              final Config? editedConfig = await navigator.push(
                MaterialPageRoute(
                  builder: (context) => EditConfig(index: index),
                ),
              );
              if (editedConfig != null) {
                ref.watch(configsProvider.notifier).addListener(saveConfigs);
                final configs = ref.watch(configsProvider);
                configs![index] = editedConfig;
                ref
                    .watch(configsProvider.notifier)
                    .state = configs;
              }
              navigator.pop();
            },
            child: const ListTile(
              leading: Icon(
                Icons.edit_rounded,
              ),
              title: Text('Edit'),
            ),
          ),
          PopupMenuItem(
            onTap: () {
              final index = ref.watch(configsProvider)!.indexOf(config);
              ref.watch(configsProvider.notifier).state!.removeAt(index);
              final configs = ref.watch(configsProvider);
              ref.watch(currentConfigIndexProvider.notifier).state =
                  (configs != null && configs.isNotEmpty)
                      ? configs.indexOf(configs.last)
                      : -1;
            },
            child: const ListTile(
              leading: Icon(Icons.delete_rounded),
              title: Text('Delete'),
            ),
          ),
        ];
      },
    );
  }
}
