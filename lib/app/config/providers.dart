import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kuberneteslib/kuberneteslib.dart';

final configsProvider = StateProvider<List<Config>>((ref) => []);
final currentConfigIndexProvider = StateProvider((ref) {
  final configs = ref.watch(configsProvider);
  return configs.length - 1;
});
final currentConfigProvider = StateProvider<Config?>(
  (ref) {
    final configs = ref.watch(configsProvider);
    final index = ref.watch(currentConfigIndexProvider);
    if (configs.isNotEmpty && index >= 0) {
      return configs[index];
    }
    return null;
  },
);

final contextsProvider = StateProvider<List<Context>>(
  (ref) {
    final contexts = <Context>[];
    final config = ref.watch(currentConfigProvider);
    if (config == null) return contexts;

    contexts.addAll(config.contexts);
    return contexts;
  },
);
final currentContextIndexProvider = StateProvider<int>(
  (ref) {
    final contexts = ref.watch(contextsProvider);
    return contexts.length - 1;
  },
);
final currentContextProvider = StateProvider<Context?>(
  (ref) {
    final contexts = ref.watch(contextsProvider);
    final index = ref.watch(currentContextIndexProvider);
    if (index < 0) return null;
    return contexts[index];
  },
);
