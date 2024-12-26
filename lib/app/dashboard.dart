import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kubectl_dashboard/app/dashboard_large.dart';
import 'package:kubectl_dashboard/app/dashboard_small.dart';
import 'package:platform/platform.dart';

class DashboardView extends ConsumerWidget {
  const DashboardView({this.contextIndex, super.key});

  final int? contextIndex;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const platform = LocalPlatform();
    if (platform.isAndroid || platform.isIOS) {
      return DashboardSmall(
        contextIndex: contextIndex,
      );
    }
    return DashboardLarge(
      contextIndex: contextIndex,
    );
  }
}
