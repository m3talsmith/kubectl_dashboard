import 'dart:convert';
import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../auth.dart';
import '../errors.dart';
import 'resources/properties.dart';

class Resource {
  Metadata? metadata;
  Spec? spec;
  Status? status;

  static Future<List<Resource>> list({
    required WidgetRef ref,
    required String resource,
    String? namespace,
    String? api,
  }) async {
    api ??= '/api/v1';

    final auth = ref.watch(authenticationProvider);
    if (auth == null) return [];
    if (auth.cluster == null) return [];

    final resources = <Resource>[];

    final resourcePath = (namespace != null)
        ? '$api/namespaces/$namespace/$resource'
        : '$api/$resource';
    final uri = Uri.parse('${auth.cluster!.server!}$resourcePath');

    final response = await auth.get(uri);
    if (response.statusCode > 299) {
      log('[ERROR] list: status: ${response.statusCode} error: ${response.body}');
      ref
          .watch(errorsProvider.notifier)
          .state
          .add(Error(message: response.body, statusCode: response.statusCode));
      return [];
    }
    final dataMap = jsonDecode(response.body);

    for (var item in dataMap['items']) {
      final resource = Resource.fromMap(item);
      resources.add(resource);
    }
    return resources;
  }

  Resource.fromMap(Map<String, dynamic> data) {
    if (data.isEmpty) return;

    if (data.containsKey('metadata') &&
        (data['metadata'] as Map<String, dynamic>).entries.isNotEmpty) {
      metadata = Metadata.fromMap(data['metadata']);
    }
    if (data.containsKey('spec') &&
        (data['spec'] as Map<String, dynamic>).entries.isNotEmpty) {
      spec = Spec.fromMap(data['spec']);
    }
    if (data.containsKey('status') &&
        (data['status'] as Map<String, dynamic>).entries.isNotEmpty) {
      status = Status.fromMap(data['status']);
    }
  }
}
