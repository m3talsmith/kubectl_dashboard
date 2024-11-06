import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kubectl_dashboard/app.dart';
import 'package:kubectl_dashboard/app/config.dart';
import 'package:kubectl_dashboard/app/config/providers.dart';
import 'package:kubectl_dashboard/app/preferences.dart';
import 'package:kubectl_dashboard/window.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final window = Window();
  await window.ensureInitialized();

  final loadedConfigs = await loadConfigs();

  runApp(
    ProviderScope(
      overrides: [
        fullscreenProvider.overrideWith((ref) => window.fullscreen),
        preferencesProvider.overrideWith((ref) => window.preferences),
        configsProvider.overrideWith((ref) => loadedConfigs),
      ],
      child: const App(),
    ),
  );
}
