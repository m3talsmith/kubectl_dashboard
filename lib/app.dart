import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kubectl_dashboard/app/config.dart';
import 'package:kubectl_dashboard/app/config/add_config.dart';
import 'package:kubectl_dashboard/app/config/config_tile_item.dart';

import 'app/config/providers.dart';

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final configs = ref.watch(configsProvider);
    ref.watch(configsProvider.notifier).addListener(saveConfigs);

    final currentConfigIndex = ref.watch(currentConfigIndexProvider);
    final Config? currentConfig = configs?[currentConfigIndex];

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Kubectl Dashboard',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: Builder(builder: (context) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Kubectl Dashboard'),
          ),
          body: const Text('home'),
          endDrawer: Drawer(
            child: ListView(
              children: [
                if (configs != null)
                  ...configs.map((e) {
                    final index = configs.indexOf(e);

                    onTap() {
                      ref.watch(currentConfigIndexProvider.notifier).state =
                          index;
                      Navigator.of(context).pop();
                    }

                    return ConfigListTile(
                      config: e,
                      selected: currentConfig,
                      onTap: onTap,
                    );
                  }),
                const Divider(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton.icon(
                    onPressed: () async {
                      final Config? config =
                          await Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const AddConfigForm(),
                      ));
                      if (config != null) {
                        final c = (configs == null) ? [config] : configs
                          ..add(config);
                        final index = c.length - 1;
                        ref.watch(currentConfigIndexProvider.notifier).state =
                            index;
                        ref.watch(configsProvider.notifier).state = c;
                        ref.invalidate(configsProvider);
                      }
                    },
                    icon: const Icon(Icons.add),
                    label: const Text('Add Cluster'),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
