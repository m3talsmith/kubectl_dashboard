import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../pods.dart';

final podsProvider = StateProvider<List<Pod>>((ref) => [],);