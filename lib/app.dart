import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kubectl_dashboard/app/app_drawer.dart';
import 'package:kubectl_dashboard/app/config/providers.dart';
import 'package:kubectl_dashboard/app/dashboard.dart';
import 'package:kubectl_dashboard/app/errors.dart';
import 'package:kubectl_dashboard/app/preferences.dart';
import 'package:kubectl_dashboard/window.dart';
import 'package:window_manager/window_manager.dart';

import 'app/config/add_config.dart';

class App extends ConsumerStatefulWidget {
  const App({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AppState();
}

class _AppState extends ConsumerState<App> with WindowListener {
  @override
  void initState() {
    super.initState();
    windowManager.addListener(this);
  }

  @override
  void dispose() {
    windowManager.removeListener(this);
    super.dispose();
  }

  @override
  onWindowMove() async {
    super.onWindowMove();

    final fullscreen = ref.watch(fullscreenProvider);
    ref.watch(preferencesProvider.notifier).state?.fullscreen = fullscreen;

    final offset = await windowManager.getPosition();
    final preferences = ref.watch(preferencesProvider);
    final currentPosition = preferences?.windowPosition;
    final position = WindowPosition(top: offset.dx, left: offset.dy);

    if (currentPosition != null &&
        (currentPosition.top != offset.dx ||
            currentPosition.left != offset.dy)) {
      if (!fullscreen) {
        ref.watch(preferencesProvider.notifier).state?.windowPosition =
            position;
      }
    } else {
      ref.watch(preferencesProvider.notifier).state?.windowPosition = position;
    }
  }

  @override
  void onWindowResize() async {
    super.onWindowResize();

    final fullscreen = ref.watch(fullscreenProvider);
    ref.watch(preferencesProvider.notifier).state?.fullscreen = fullscreen;

    final size = await windowManager.getSize();

    if (!fullscreen) {
      ref.watch(preferencesProvider.notifier).state?.windowSize = size;
    }
  }

  @override
  Widget build(BuildContext context) {
    final config = ref.watch(currentConfigProvider);
    final errors = ref.watch(errorsProvider);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Kubectl Dashboard',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: Builder(builder: (context) {
        final fullscreen = ref.watch(fullscreenProvider);
        final size = MediaQuery.of(context).size;
        for (var err in errors) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: ErrorView(
                  error: Error(
                      message: err.message, statusCode: err.statusCode))));
        }

        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const Text('Kubectl Dashboard'),
            actions: [
              if (Platform.isLinux || Platform.isMacOS || Platform.isWindows)
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
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => const AddConfig(),
                                  ));
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
    );
  }
}
