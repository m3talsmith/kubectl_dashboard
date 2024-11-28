import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kubectl_dashboard/app/config/providers.dart';
import 'package:kuberneteslib/kuberneteslib.dart';

class ConfigListTile extends ConsumerWidget {
  const ConfigListTile({
    required this.index,
    this.selected,
    this.onTap,
    this.onEdit,
    this.onDelete,
    super.key,
  });

  final int index;
  final int? selected;
  final Function()? onTap;
  final Function()? onEdit;
  final Function()? onDelete;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final config = ref.watch(configsProvider)[index];
    if (selected != null && index == selected!) {
      return Padding(
        padding: const EdgeInsets.only(right: 16.0),
        child: ListTile(
          onTap: onTap,
          title: Text(config.displayName ?? config.currentContext ?? 'unknown'),
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
            onEdit: onEdit,
            onDelete: onDelete,
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
          onEdit: onEdit,
          onDelete: onDelete,
        ),
      ),
    );
  }
}

class ConfigListTileMenu extends ConsumerWidget {
  const ConfigListTileMenu({
    required this.config,
    this.onEdit,
    this.onDelete,
    super.key,
  });

  final Config config;
  final Function()? onEdit;
  final Function()? onDelete;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PopupMenuButton(
      itemBuilder: (context) {
        return [
          PopupMenuItem(
            onTap: onEdit,
            child: const ListTile(
              leading: Icon(
                Icons.edit_rounded,
              ),
              title: Text('Edit'),
            ),
          ),
          PopupMenuItem(
            onTap: onDelete,
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
