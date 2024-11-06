import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kubectl_dashboard/app/app_drawer.dart';
import 'package:kubectl_dashboard/app/preferences.dart';
import 'package:kubectl_dashboard/window.dart';
import 'package:window_manager/window_manager.dart';

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return NotificationListener<SizeChangedLayoutNotification>(
      onNotification: (notification) {
        final size = MediaQuery.of(context).size;
        final fullscreen = ref.watch(fullscreenProvider);
        ref.watch(preferencesProvider.notifier).state?.fullscreen = fullscreen;

        if (!fullscreen) {
          ref
              .watch(preferencesProvider.notifier)
              .state
              ?.windowSize = size;
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
                            ref.watch(fullscreenProvider.notifier).state = !fullscreen;
                          },
                          icon: Icon(fullscreen
                              ? Icons.fullscreen_exit_rounded
                              : Icons.fullscreen_rounded)),
                    )
                ],
              ),
              body: const Text('home'),
              drawer: const AppDrawer(),
            );
          }),
        ),
      ),
    );
  }
}
