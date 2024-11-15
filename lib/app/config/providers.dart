import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../config.dart';

final configsProvider = StateProvider<List<Config>>((ref) => []);
final currentConfigIndexProvider = StateProvider((ref) {
  final configs = ref.watch(configsProvider);
  return configs.indexOf(configs.last);
});
final currentConfigProvider = StateProvider<Config?>((ref) {
  final configs = ref.watch(configsProvider);
  final index = ref.watch(currentConfigIndexProvider);
  if (configs.isNotEmpty && index >= 0) {
    return configs[index];
  }
  return null;
},);
final contextsProvider = StateProvider<List<Context>>((ref) => [],);