import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:window_manager/window_manager.dart';
import 'package:kubectl_dashboard/app/preferences.dart' as pref;

final fullscreenProvider = StateProvider((ref) => false);

class Window {
  Window();

  late pref.Preferences _preferences;

  pref.Preferences get preferences => _preferences;
  bool get fullscreen => _preferences.fullscreen;
  Size? get size => _preferences.windowSize;
  WindowPosition? get position => _preferences.windowPosition;

  ensureInitialized() async {
    _preferences = await pref.loadPreferences();
    await windowManager.ensureInitialized();

    if (Platform.isLinux || Platform.isMacOS || Platform.isWindows) {

      var windowOptions = WindowOptions(
        fullScreen: fullscreen,
        size: size,
        center: (position == null),
      );

      windowManager.waitUntilReadyToShow(windowOptions, () async {
        if (position != null) {
          await windowManager.setPosition(position!.offset);
        }
        await windowManager.show();
        await windowManager.focus();
      });
    }
  }
}

class WindowPosition {
  WindowPosition({
    this.left,
    this.right,
    this.top,
    this.bottom,
    this.center,
  });

  double? left;
  double? right;
  double? top;
  double? bottom;
  double? center;

  Offset get offset => Offset(top ?? 0, left ?? 0);
}
