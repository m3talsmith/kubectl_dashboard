import 'dart:convert';
import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pluralize/pluralize.dart';

import '../auth.dart';
import '../errors.dart';
import 'resources/properties.dart';

enum ResourceKind {
  // coreAPI
  container,
  pod,
  replicationController,
  endpoints,
  service,
  configMap,
  secret,
  persistentVolumeClaim,
  volume,
  limitRange,
  podTemplate,
  binding,
  componentStatus,
  namespace,
  node,
  persistentVolume,
  resourceQuota,
  serviceAccount,
  // batchAPI
  cronJob,
  job,
  // appsAPI
  daemonSet,
  deployment,
  replicaSet,
  statefulSet,
  controllerRevision,
  // Error
  unknown;

  const ResourceKind();

  factory ResourceKind.fromString(String kind) {
    return ResourceKind.values.firstWhere(
      (e) => e.name == kind,
      orElse: () => ResourceKind.unknown,
    );
  }
}

class Resource {
  late Metadata metadata;
  Spec? spec;
  Status? status;

  late String kind;

  static const coreAPI = '/api/v1';
  static const appsAPI = '/apis/apps/v1';
  static const batchAPI = '/apis/batch/v1';

  static List<ResourceKind> get apiReadKinds {
    final ignore = [
      ResourceKind.unknown,
      ResourceKind.container,
      ResourceKind.volume,
      ResourceKind.binding,
    ];

    List<ResourceKind> values = [];
    for (var e in ResourceKind.values) {
      values.add(e);
    }
    return values
      ..removeWhere(
        (e) => ignore.contains(e),
      );
  }

  static String? getApi({required String resourceKind, bool pluralize = true}) {
    switch (ResourceKind.fromString(resourceKind)) {
      case ResourceKind.unknown:
        return null;
      case ResourceKind.daemonSet:
      case ResourceKind.deployment:
      case ResourceKind.replicaSet:
      case ResourceKind.statefulSet:
      case ResourceKind.controllerRevision:
        return appsAPI;
      case ResourceKind.cronJob:
      case ResourceKind.job:
        return batchAPI;
      default:
        return coreAPI;
    }
  }

  static Future<List<Resource>> list({
    required WidgetRef ref,
    required String resourceKind,
    bool pluralize = true,
    String? namespace = 'default',
  }) async {
    final api = Resource.getApi(resourceKind: resourceKind);

    final auth = ref.watch(authenticationProvider);
    if (auth == null) return [];
    if (auth.cluster == null) return [];

    final resources = <Resource>[];

    final p = Pluralize();
    if (pluralize && p.isSingular(resourceKind)) {
      resourceKind = p.pluralize(resourceKind.toLowerCase(), 3, false);
    }

    final resourcePath = (namespace != null)
        ? '$api/namespaces/$namespace/$resourceKind'
        : '$api/$resourceKind';
    final uri = Uri.parse('${auth.cluster!.server!}$resourcePath');

    final response = await auth.get(uri);
    if (response.statusCode > 299) {
      log('[ERROR] list: uri: $uri, status: ${response.statusCode} error: ${response.body}');
      ref
          .watch(errorsProvider.notifier)
          .state
          .add(Error(message: response.body, statusCode: response.statusCode));
      return [];
    }
    final data = jsonDecode(response.body);

    for (var item in data['items']) {
      item['kind'] = resourceKind;
      item['api'] = api;
      final resource = Resource.fromMap(item);
      resources.add(resource);
    }

    return resources;
  }

  static Future<Resource?> show({
    required WidgetRef ref,
    required String resourceKind,
    required String resourceName,
    bool pluralize = true,
    String? namespace = 'default',
  }) async {
    final api = Resource.getApi(resourceKind: resourceKind);

    final auth = ref.watch(authenticationProvider);
    if (auth == null) return null;
    if (auth.cluster == null) return null;

    final p = Pluralize();
    if (pluralize && p.isSingular(resourceKind)) {
      resourceKind = p.pluralize(resourceKind.toLowerCase(), 3, false);
    }

    final resourcePath = (namespace != null)
        ? '$api/namespaces/$namespace/$resourceKind/$resourceName'
        : '$api/$resourceKind/$resourceName';
    final uri = Uri.parse('${auth.cluster!.server!}$resourcePath');

    final response = await auth.get(uri);
    if (response.statusCode > 299) {
      log('[ERROR] list: uri: $uri, status: ${response.statusCode} error: ${response.body}');
      ref
          .watch(errorsProvider.notifier)
          .state
          .add(Error(message: response.body, statusCode: response.statusCode));
      return null;
    }
    final data = jsonDecode(response.body);

    data['kind'] = pluralize ? p.singular(resourceKind) : resourceKind;
    return Resource.fromMap(data);
  }

  Resource.fromMap(Map<String, dynamic> data) {
    if (data.isEmpty) return;

    kind = data['kind'];
    metadata = Metadata.fromMap(data['metadata']);
    if (data.containsKey('spec')) {
      spec = Spec.fromMap(data['spec']);
    }
    if (data.containsKey('status')) {
      status = Status.fromMap(data['status']);
    }
  }
}
