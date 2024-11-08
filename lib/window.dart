import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:window_manager/window_manager.dart';
import 'package:kubectl_dashboard/app/preferences.dart' as pref;

final fullscreenProvider = StateProvider((ref) => false);

class Window {
  Window();

  late pref.Preferences _preferences;

  get preferences => _preferences;
  get fullscreen => _preferences.fullscreen;
  get size => _preferences.windowSize;

  ensureInitialized() async {
    _preferences = await pref.loadPreferences();

    if (Platform.isLinux || Platform.isMacOS || Platform.isWindows) {
      await windowManager.ensureInitialized();

      var windowOptions = WindowOptions(
        fullScreen: fullscreen,
        size: size,
        center: true,
      );

      windowManager.waitUntilReadyToShow(windowOptions, () async {
        await windowManager.show();
        await windowManager.focus();
      });
    }
  }
}
