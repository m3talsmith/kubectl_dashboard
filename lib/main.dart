import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kubectl_dashboard/app.dart';
import 'package:kubectl_dashboard/app/config.dart';
import 'package:kubectl_dashboard/app/config/providers.dart';
import 'package:kubectl_dashboard/app/preferences.dart';
import 'package:kubectl_dashboard/window_providers.dart';
import 'package:window_manager/window_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final preferences = await loadPreferences();
  final isFullscreen = preferences.fullscreen;

  if (Platform.isLinux || Platform.isMacOS || Platform.isWindows) {
    await windowManager.ensureInitialized();
    final windowSize = preferences.windowSize;

    var windowOptions = WindowOptions(
        center: true,
        fullScreen: isFullscreen,
        size: windowSize);

    windowManager.waitUntilReadyToShow(windowOptions, () async {
      await windowManager.show();
      await windowManager.focus();
    });
  }

  final loadedConfigs = await loadConfigs();

  runApp(
    ProviderScope(
      overrides: [
        fullscreenProvider.overrideWith((ref) => isFullscreen),
        preferencesProvider.overrideWith((ref) => preferences),
        configsProvider.overrideWith((ref) => loadedConfigs),
      ],
      child: const App(),
    ),
  );
}
