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
      await DesktopWindow.setMaxWindowSize(
        Size(view.physicalSize.width, view.physicalSize.height),
      );
      await DesktopWindow.setMinWindowSize(
        Size(view.physicalSize.width / 3, view.physicalSize.height / 3),
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
