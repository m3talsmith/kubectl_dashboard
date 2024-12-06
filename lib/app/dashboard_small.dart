import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'auth.dart';
import 'config/providers.dart';

class DashboardSmall extends ConsumerStatefulWidget {
  const DashboardSmall({this.contextIndex, super.key});

  final int? contextIndex;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DashboardSmallState();
}

class _DashboardSmallState extends ConsumerState<DashboardSmall> {
  late int _tabIndex;
  late int _subTabIndex;

  @override
  void initState() {
    super.initState();
    setState(() {
      _tabIndex = widget.contextIndex ?? 0;
      _subTabIndex = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    final config = ref.watch(currentConfigProvider);
    final currentContext = ref.watch(currentContextProvider);
    final authentication = ref.watch(authenticationProvider);
    String resourceKind = '';

    return Scaffold(
      body: Text('small'),
    );
  }
}
