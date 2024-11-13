import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract class Resource {
  String? name;

  static Future<List<Resource>> list(WidgetRef ref) async {
    throw UnimplementedError('Resource not implemented');
  }
}