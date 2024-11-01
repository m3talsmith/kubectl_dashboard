import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kubectl_dashboard/app/config.dart';
import 'package:kubectl_dashboard/app/config/add_config.dart';
// import 'package:riverpod_annotation/riverpod_annotation.dart';

// part 'app.g.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const AppConsumer();
  }
}

final currentConfigIndexProvider = StateProvider((ref) => 0);
final configsProvider = StateProvider((ref) => []);

// class AppState extends _$AppState {
//   int currentConfigIndex = 0;
//   List<Config> configs = [];
//
//   @override
//   AppState build() => this;
//
//   Config? get currentConfig =>
//       (configs.isNotEmpty && currentConfigIndex < configs.length)
//           ? configs[currentConfigIndex]
//           : null;
//
//   set currentConfig(Config? config) {
//     if (config == null) return;
//     if (!configs.contains(config)) {
//       configs.add(config);
//     }
//     currentConfigIndex = configs.indexOf(config);
//   }
// }

class AppConsumer extends ConsumerWidget {
  const AppConsumer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final configs = ref.watch(configsProvider);
    final currentConfigIndex = ref.watch(currentConfigIndexProvider);

    log('currentConfigIndex: $currentConfigIndex');

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Kubectl Dashboard',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: Builder(
        builder: (context) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Kubectl Dashboard'),
            ),
            body: const Text('home'),
            endDrawer: Drawer(
              child: ListView(
                children: [
                  ...configs.map(
                    (e) => ListTile(
                      title: Text(e.currentContext ?? 'unknown'),
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: () async {
                      final Config? config = await Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const AddConfigForm(),
                          ));
                      ref.read(currentConfigIndexProvider.notifier).state += 1;
                      ref.read(configsProvider.notifier).state.add(config);
                    },
                    icon: const Icon(Icons.add),
                    label: const Text('Add Cluster'),
                  ),
                ],
              ),
            ),
          );
        }
      ),
    );
  }
}
