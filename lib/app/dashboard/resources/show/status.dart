import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kuberneteslib/kuberneteslib.dart';

import '../providers.dart';
import 'status_helper.dart';
import 'status_switch_cases.dart';

class StatusPage extends ConsumerWidget {
  const StatusPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final resource = ref.watch(currentResourceProvider);
    if (resource == null) {
      return const SizedBox.shrink();
    }
    final kind = resource.kind;
    if (kind == null) {
      return const SizedBox.shrink();
    }
    if (resource.status == null) {
      return const SizedBox.shrink();
    }

    final statusKind = ResourceKind.fromString(kind);
    final status = StatusHelper.fromKind(statusKind, resource.status!);

    if (status == null) {
      return const SizedBox.shrink();
    }

    log('[StatusPage] status: ${status.toJson()}, runtimeType: ${status.runtimeType}');

    return buildStatus(status: status);
  }
}
