import 'dart:io';

import 'package:desktop_window/desktop_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kubectl_dashboard/app.dart';
import 'package:kubectl_dashboard/app/config.dart';
import 'package:kubectl_dashboard/app/config/providers.dart';
import 'package:kubectl_dashboard/window_providers.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var isFullscreen = false;

  if (Platform.isLinux || Platform.isMacOS || Platform.isWindows) {
    isFullscreen = await DesktopWindow.getFullScreen();
    if (!isFullscreen) {
      final view = WidgetsBinding.instance.platformDispatcher.views.first;
      await DesktopWindow.setWindowSize(
        Size(view.physicalSize.width / 2.5, view.physicalSize.height / 2.5),
      );
    }
  }

  final loadedConfigs = await loadConfigs();

  runApp(
    ProviderScope(
      overrides: [
        fullscreenProvider.overrideWith(
          (ref) => isFullscreen,
        ),
        configsProvider.overrideWith(
          (ref) => loadedConfigs,
        ),
      ],
      child: const App(),
    ),
  );
}
