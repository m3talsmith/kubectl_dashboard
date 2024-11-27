import 'dart:convert';
import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:humanizer/humanizer.dart';
import 'package:kubectl_dashboard/app/dashboard/resources/properties/meta/object_meta.dart';

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
  late ObjectMeta metadata;
  Spec? spec;
  Status? status;

  late String kind;
  late String namespace;

  static const coreAPI = '/api/v1';
  static const appsAPI = '/apis/apps/v1';
  static const batchAPI = '/apis/batch/v1';

  static const ignoreList = [
    ResourceKind.unknown,
    ResourceKind.container,
    ResourceKind.volume,
    ResourceKind.binding,
  ];

  static const ignoreShow = [
    ...ignoreList,
    ResourceKind.persistentVolume,
  ];

  static List<ResourceKind> get apiReadKinds {
    List<ResourceKind> values = [];
    for (var e in ResourceKind.values) {
      values.add(e);
    }
    return values
      ..sort(
        (a, b) => a.name.compareTo(b.name),
      )
      ..removeWhere(
        (e) => ignoreList.contains(e),
      );
  }

  static String? getApi({required String resourceKind, bool pluralize = true}) {
    switch (ResourceKind.fromString(resourceKind)) {
      case ResourceKind.unknown:
        return coreAPI;
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

    var resourceKindPluralized = resourceKind;
    if (pluralize) {
      resourceKindPluralized = resourceKind.toLowerCase().toPluralForm();
    }

    final resourcePath = (namespace != null)
        ? '$api/namespaces/$namespace/$resourceKindPluralized'
        : '$api/$resourceKindPluralized';
    final uri = Uri.parse('${auth.cluster!.server!}$resourcePath');

    final response = await auth.get(uri);
    if (response.statusCode > 299) {
      log('[ERROR] list: resourceKind: $resourceKind, uri: $uri, status: ${response.statusCode} error: ${response.body}');
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

    return resources
      ..sort(
        (a, b) => a.namespace.compareTo(b.namespace),
      );
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

    var resourceKindPluralized = resourceKind;
    if (pluralize) {
      resourceKindPluralized = resourceKind.toLowerCase().toPluralForm();
    }

    final resourcePath = (namespace != null)
        ? '$api/namespaces/$namespace/$resourceKindPluralized/$resourceName'
        : '$api/$resourceKindPluralized/$resourceName';
    final uri = Uri.parse('${auth.cluster!.server!}$resourcePath');

    final response = await auth.get(uri);
    if (response.statusCode > 299) {
      log('[ERROR] show: resourceKind: $resourceKind, uri: $uri, status: ${response.statusCode} error: ${response.body}');
      ref
          .watch(errorsProvider.notifier)
          .state
          .add(Error(message: response.body, statusCode: response.statusCode));
      return null;
    }
    final data = jsonDecode(response.body);

    data['kind'] = resourceKind.toSingularForm();
    return Resource.fromMap(data);
  }

  delete({required WidgetRef ref}) async {
    final api = Resource.getApi(resourceKind: kind);

    final auth = ref.watch(authenticationProvider);
    if (auth == null) return null;
    if (auth.cluster == null) return null;

    var resourceKindPluralized = kind.toLowerCase().toPluralForm();

    final resourcePath =
        '$api/namespaces/$namespace/$resourceKindPluralized/${metadata.name}';
    final uri = Uri.parse('${auth.cluster!.server!}$resourcePath');

    final response = await auth.delete(uri);
    if (response.statusCode > 299) {
      log('[ERROR] delete: resourceKind: $kind, uri: $uri, status: ${response.statusCode} error: ${response.body}');
      ref
          .watch(errorsProvider.notifier)
          .state
          .add(Error(message: response.body, statusCode: response.statusCode));
      return null;
    }
  }

  Resource.fromMap(Map<String, dynamic> data) {
    if (data.isEmpty) return;

    kind = data['kind'];
    metadata = ObjectMeta.fromMap(data['metadata']);
    namespace = metadata.namespace ?? 'default';
    if (data.containsKey('spec')) {
      spec = Spec.fromMap(data['spec'], kind: ResourceKind.fromString(kind));
    }
    if (data.containsKey('status')) {
      status = Status.fromMap(data['status']);
    }
  }
}
