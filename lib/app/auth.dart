import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kuberneteslib/kuberneteslib.dart';

final authenticationProvider = StateProvider<ClusterAuth?>(
  (ref) => null,
);
