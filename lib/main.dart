import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kubectl_dashboard/app.dart';
import 'package:kubectl_dashboard/app/config.dart';
import 'package:kubectl_dashboard/app/config/providers.dart';
import 'package:kubectl_dashboard/app/preferences.dart';
import 'package:kubectl_dashboard/window.dart';
import 'package:kuberneteslib/kuberneteslib.dart';
import 'package:platform/platform.dart';

import 'app/auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final loadedConfigs = await loadConfigs();
  int currentConfigIndex = -1;
  Config? currentConfig;
  int currentContextIndex = -1;
  Context? currentContext;

  bool isFullscreened = false;
  Preferences? preferences;
  const platform = LocalPlatform();
  if (platform.isMacOS ||
      platform.isWindows ||
      platform.isLinux ||
      platform.isFuchsia) {
    final window = Window();
    await window.ensureInitialized();

    currentConfigIndex =
        (loadedConfigs.isNotEmpty) ? window.preferences.currentConfigIndex : -1;
    currentConfig = (loadedConfigs.isNotEmpty)
        ? loadedConfigs[(currentConfigIndex < 0) ? 0 : currentConfigIndex]
        : null;

    currentContextIndex = window.preferences.currentContextIndex;

    isFullscreened = window.fullscreen;
    preferences = window.preferences;
  }

  final auth =
      (currentConfig != null) ? ClusterAuth.fromConfig(currentConfig) : null;
  if (auth != null) await auth.ensureInitialization();

  final loadedContexts = currentConfig?.contexts;
  currentContext =
      loadedContexts?[(currentContextIndex < 0) ? 0 : currentContextIndex];

  final overrides = [
    fullscreenProvider.overrideWith((ref) => isFullscreened),
    preferencesProvider.overrideWith((ref) => preferences),
    configsProvider.overrideWith((ref) => loadedConfigs),
    currentConfigIndexProvider.overrideWith((ref) => currentConfigIndex),
    currentConfigProvider.overrideWith((ref) => currentConfig),
    contextsProvider.overrideWith((ref) => loadedContexts ?? []),
    currentContextIndexProvider.overrideWith((ref) => currentContextIndex),
    currentContextProvider.overrideWith((ref) => currentContext),
    authenticationProvider.overrideWith((ref) => auth),
  ];

  runApp(
    ProviderScope(
      overrides: overrides,
      child: const App(),
    ),
  );
}
