import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kubectl_dashboard/app.dart';
import 'package:kubectl_dashboard/app/config.dart';
import 'package:kubectl_dashboard/app/config/providers.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final loadedConfigs = await loadConfigs();
  runApp(
    ProviderScope(
      overrides: [
        configsProvider.overrideWith(
          (ref) => loadedConfigs,
        ),
      ],
      child: const App(),
    ),
  );
}
