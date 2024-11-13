import 'dart:convert';
import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kubectl_dashboard/app/auth.dart';
import 'package:kubectl_dashboard/app/config/providers.dart';
import 'package:kubectl_dashboard/app/dashboard/resources.dart';

enum PodApiEndpoint {
  list(path: '/api/v1/pods');
  
  const PodApiEndpoint({this.path});
  
  final String? path;
}

class Pod implements Resource {
  @override
  String? name;

  @override
  static Future<List<Resource>> list(WidgetRef ref) async {
    final auth = ref.watch(authenticationProvider);
    if (auth == null) return [];
    if (auth.cluster == null) return [];

    final uri = Uri.parse('${auth.cluster!.server!}${PodApiEndpoint.list.path}');
    log('[DEBUG] server: $uri');

    final response = await auth.get(uri);
    if (response.statusCode > 299) {
      log('[PODS] list: status: ${response.statusCode} error: ${response.body}');
      return [];
    }
    log('[DEBUG] data: ${response.body}');
    final dataMap = json.decode(response.body);
    log('[DEBUG] dataMap: $dataMap');
    return [];
  }

  Pod.fromJson(String data) {
    if (data.isEmpty) return;
    final json = jsonDecode(data);
    name = json['name'];
  }
}