import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../config.dart';

final configsProvider = StateProvider<List<Config>?>((ref) => null);
final currentConfigIndexProvider = StateProvider((ref) {
  final configs = ref.watch(configsProvider);
  return configs?.indexOf(configs.last) ?? -1;
});
final currentConfigProvider = Provider<Config?>((ref) {
  var configs = ref.watch(configsProvider);
  var index = ref.watch(currentConfigIndexProvider);
  if (configs != null && configs.isNotEmpty && index >= 0) {
    return configs[index];
  }
  return null;
},);