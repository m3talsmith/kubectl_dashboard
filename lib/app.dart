import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kubectl_dashboard/app/config.dart';
import 'package:kubectl_dashboard/app/app_drawer.dart';

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
          endDrawer: const AppDrawer(),
        );
      }),
    );
  }
}
