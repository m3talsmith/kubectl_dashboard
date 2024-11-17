import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../resources.dart';

final resourcesProvider = StateProvider<List<Resource>>(
  (ref) => [],
);
