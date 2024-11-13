import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kubectl_dashboard/app/app_drawer.dart';
import 'package:kubectl_dashboard/app/config/providers.dart';
import 'package:kubectl_dashboard/app/dashboard.dart';
import 'package:kubectl_dashboard/app/preferences.dart';
import 'package:kubectl_dashboard/window.dart';
import 'package:window_manager/window_manager.dart';

import 'app/config.dart';
import 'app/config/add_config.dart';

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final config = ref.watch(currentConfigProvider);
    final configs = ref.watch(configsProvider);

    return NotificationListener<SizeChangedLayoutNotification>(
      onNotification: (notification) {
        final size = MediaQuery.of(context).size;
        final fullscreen = ref.watch(fullscreenProvider);
        ref.watch(preferencesProvider.notifier).state?.fullscreen = fullscreen;

        if (!fullscreen) {
          ref.watch(preferencesProvider.notifier).state?.windowSize = size;
        }

        return true;
      },
      child: SizeChangedLayoutNotifier(
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Kubectl Dashboard',
          theme: ThemeData(
            useMaterial3: true,
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          ),
          home: Builder(builder: (context) {
            final fullscreen = ref.watch(fullscreenProvider);
            final size = MediaQuery.of(context).size;

            return Scaffold(
              appBar: AppBar(
                centerTitle: true,
                title: const Text('Kubectl Dashboard'),
                actions: [
                  if (Platform.isLinux ||
                      Platform.isMacOS ||
                      Platform.isWindows)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: IconButton(
                          onPressed: () {
                            windowManager.setFullScreen(!fullscreen);
                            ref.watch(fullscreenProvider.notifier).state =
                                !fullscreen;
                          },
                          icon: Icon(fullscreen
                              ? Icons.fullscreen_exit_rounded
                              : Icons.fullscreen_rounded)),
                    )
                ],
              ),
              body: (config != null)
                  ? DashboardView(config: config)
                  : Center(
                      child: Card(
                        child: SizedBox(
                          height: size.height / 3,
                          width: size.width / 3,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              children: [
                                const Expanded(
                                  child: Text(
                                      'Please select a config from the drawer or add a new one.'),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: FilledButton.icon(
                                    onPressed: () async {
                                      ref
                                          .watch(configsProvider.notifier)
                                          .addListener(saveConfigs);
                                      final Config? config =
                                          await Navigator.of(context)
                                              .push(MaterialPageRoute(
                                        builder: (context) => const AddConfig(),
                                      ));
                                      if (config != null) {
                                        final c = (configs == null)
                                            ? [config]
                                            : configs;
                                        if (!c.contains(config)) {
                                          c.add(config);
                                        }
                                        final index = c.length - 1;
                                        ref
                                            .watch(currentConfigIndexProvider
                                                .notifier)
                                            .state = index;
                                        ref
                                            .watch(configsProvider.notifier)
                                            .state = c;
                                      }
                                    },
                                    icon: const Icon(Icons.add),
                                    label: const Text('Add Cluster'),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
              drawer: const AppDrawer(),
            );
          }),
        ),
      ),
    );
  }
}
