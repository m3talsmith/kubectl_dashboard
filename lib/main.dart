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
  var currentConfigIndex = window.preferences.currentConfigIndex;
  var currentConfig =
      loadedConfigs?[(currentConfigIndex < 0) ? 0 : currentConfigIndex];

  final loadedContexts = currentConfig?.contexts;
  final currentContextIndex = window.preferences.currentContextIndex;
  final currentContext =
      loadedContexts?[(currentContextIndex < 0) ? 0 : currentContextIndex];

  final overrides = [
    fullscreenProvider.overrideWith((ref) => window.fullscreen),
    preferencesProvider.overrideWith((ref) => window.preferences),
    configsProvider.overrideWith((ref) => loadedConfigs ?? []),
    currentConfigIndexProvider.overrideWith((ref) => currentConfigIndex),
    currentConfigProvider.overrideWith((ref) => currentConfig),
    contextsProvider.overrideWith((ref) => loadedContexts ?? []),
    currentContextIndexProvider.overrideWith((ref) => currentContextIndex),
    currentContextProvider.overrideWith((ref) => currentContext),
    authenticationProvider.overrideWith((ref) {
      if (currentConfig != null) {
        return Auth.fromConfig(currentConfig);
      }
      return null;
    }),
  ];

  runApp(
    ProviderScope(
      overrides: overrides,
      child: const App(),
    ),
  );
}
