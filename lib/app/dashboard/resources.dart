import 'dart:convert';
import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../auth.dart';
import '../errors.dart';

class Resource {
  String? name;

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

    log('[DEBUG] resource: $resource');
    final resources = <Resource>[];

    final resourcePath = (namespace != null)
        ? '$api/namespaces/$namespace/$resource'
        : '$api/$resource';
    log('[DEBUG] resourcePath: $resourcePath');
    final uri = Uri.parse('${auth.cluster!.server!}$resourcePath');

    final response = await auth.get(uri);
    if (response.statusCode > 299) {
      log('[ERROR] list: status: ${response.statusCode} error: ${response.body}');
      if (namespace == null) {
        return Resource.list(
            ref: ref, resource: resource, namespace: 'default');
      } else {
        ref.watch(errorsProvider.notifier).state.add(
            Error(message: response.body, statusCode: response.statusCode));
        return [];
      }
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
    name = data['metadata']['name'];
  }
}
