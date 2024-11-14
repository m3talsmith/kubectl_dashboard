import 'dart:convert';
import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kubectl_dashboard/app/auth.dart';
import 'package:kubectl_dashboard/app/dashboard/resources.dart';
import 'package:kubectl_dashboard/app/errors.dart';

enum PodApiEndpoint {
  list(path: '/api/v1/pods');

  const PodApiEndpoint({this.path});

  final String? path;
}

class Pod implements Resource {
  @override
  String? name;

  static Future<List<Resource>> list(WidgetRef ref) async {
    final auth = ref.watch(authenticationProvider);
    if (auth == null) return [];
    if (auth.cluster == null) return [];

    final pods = <Pod>[];

    final uri =
        Uri.parse('${auth.cluster!.server!}${PodApiEndpoint.list.path}');

    final response = await auth.get(uri);
    if (response.statusCode > 299) {
      log('[ERROR] list: status: ${response.statusCode} error: ${response.body}');
      ref
          .watch(errorsProvider.notifier)
          .state
          .add(Error(message: response.body, statusCode: response.statusCode));
      return [];
    }
    final dataMap = json.decode(response.body);

    for (var item in dataMap['items']) {
      final pod = Pod.fromMap(item);
      pods.add(pod);
    }
    return pods;
  }

  Pod.fromMap(Map<String, dynamic> data) {
    if (data.isEmpty) return;
    name = data['metadata']['name'];
  }
}
