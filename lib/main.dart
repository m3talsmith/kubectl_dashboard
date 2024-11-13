import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kubectl_dashboard/app.dart';
import 'package:kubectl_dashboard/app/config.dart';
import 'package:kubectl_dashboard/app/config/providers.dart';
import 'package:kubectl_dashboard/app/preferences.dart';
import 'package:kubectl_dashboard/window.dart';

import 'app/auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final window = Window();
  await window.ensureInitialized();

  final loadedConfigs = await loadConfigs();
  int currentConfigIndex = window.preferences.currentConfigIndex;
  if (currentConfigIndex < 0 && loadedConfigs != null) {
    currentConfigIndex = 0;
  }

  runApp(
    ProviderScope(
      overrides: [
        fullscreenProvider.overrideWith((ref) => window.fullscreen),
        preferencesProvider.overrideWith((ref) => window.preferences),
        configsProvider.overrideWith((ref) => loadedConfigs),
        currentConfigIndexProvider.overrideWith((ref) => currentConfigIndex),
        authenticationProvider.overrideWith((ref) {
          final config = loadedConfigs?[currentConfigIndex];
          if (config != null) {
            return Auth.fromConfig(config);
          }
          return null;
        }),
      ],
      child: const App(),
    ),
  );
}
