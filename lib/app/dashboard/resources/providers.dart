import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kubernetes/kubernetes.dart';

final resourcesProvider = StateProvider<List<Resource>>((ref) => []);
final currentResourceProvider = StateProvider<Resource?>((ref) => null);
