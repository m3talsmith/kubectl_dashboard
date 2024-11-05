import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kubectl_dashboard/app/config.dart';
import 'package:kubectl_dashboard/app/config/add_config.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const AppConsumer();
  }
}

final currentConfigIndexProvider = StateProvider((ref) => 0);
final configsProvider = StateProvider<List<Config>?>((ref) => null);

class AppConsumer extends ConsumerWidget {
  const AppConsumer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final configs = ref.watch(configsProvider);
    ref.watch(configsProvider.notifier).addListener(saveConfigs);
    ref.watch(configsProvider.notifier).addListener(
      (state) {
        log('configs: $configs');
      },
    );

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
                  ...configs.map(
                    (e) => ListTile(
                      title: Text(e.currentContext ?? 'unknown'),
                    ),
                  ),
                ElevatedButton.icon(
                  onPressed: () async {
                    final Config? config =
                        await Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const AddConfigForm(),
                    ));
                    if (config != null) {
                      final c = (configs == null) ? [config] : configs
                        ..add(config);
                      ref.watch(currentConfigIndexProvider.notifier).state += 1;
                      ref.watch(configsProvider.notifier).state = c;
                      ref.invalidate(configsProvider);
                    }
                  },
                  icon: const Icon(Icons.add),
                  label: const Text('Add Cluster'),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
