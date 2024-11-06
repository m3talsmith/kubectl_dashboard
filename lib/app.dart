import 'dart:io';

import 'package:desktop_window/desktop_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kubectl_dashboard/app/app_drawer.dart';
import 'package:kubectl_dashboard/window_providers.dart';

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
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
            title: const Text('Kubectl Dashboard'),
            actions: [
              if (Platform.isLinux || Platform.isMacOS || Platform.isWindows)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: IconButton(
                      onPressed: () {
                        DesktopWindow.setFullScreen(!fullscreen);
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
    );
  }
}
