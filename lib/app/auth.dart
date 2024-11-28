import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kubernetes/kubernetes.dart';

final authenticationProvider = StateProvider<ClusterAuth?>(
  (ref) => null,
);
