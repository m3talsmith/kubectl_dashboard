import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kubectl_dashboard/app/auth.dart';
import 'package:kubectl_dashboard/app/config.dart';
import 'package:kubectl_dashboard/app/config/providers.dart';
import 'package:kubectl_dashboard/app/dashboard/dashboard_list_tile.dart';
import 'package:kubectl_dashboard/app/dashboard/resources/pods/pods_list.dart';
import 'package:kubectl_dashboard/app/dashboard/resources/pods/providers.dart';

import 'dashboard/resources/pods.dart';

class DashboardView extends ConsumerStatefulWidget {
  const DashboardView({required this.config, super.key});

  final Config config;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DashboardViewState();

}

class _DashboardViewState extends ConsumerState<DashboardView> {
  late int _index;

  @override
  void initState() {
    super.initState();
    setState(() {
      _index = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> tabs = [
      {
        'title': 'Pods',
        'onTap': () async {
          final pods = await Pod.list(ref);
          ref.watch(podsProvider.notifier).state = pods as List<Pod>;
        },
        'widget': const PodsList(),
      },
      {
        'title': 'Services',
        'onTap': () {},
        'widget': const Center(child: Text('Services'),),
      },
      {
        'title': 'Deployments',
        'onTap': () {},
        'widget': const Center(child: Text('Deployments'),),
      },
      {
        'title': 'Ingresses',
        'onTap': () {},
        'widget': const Center(child: Text('Ingresses'),),
      },
      {
        'title': 'Certificates',
        'onTap': () {},
        'widget': const Center(child: Text('Certificates'),),
      },
    ];

    final config = ref.watch(currentConfigProvider);
    final authentication = ref.watch(authenticationProvider);
    final size = MediaQuery.of(context).size;
    return (config == null || authentication == null)
      ? const Center(child: Text('Authenticating...'),)
      : Row(
      children: [
        SizedBox(
          height: size.height,
          width: 200,
          child: ListView(
            shrinkWrap: true,
            children: tabs.map((e) {
              final i = tabs.indexOf(e);
              final selected = i == _index;
              final tile = DashboardListTile(
                title: Text(e['title']),
                selected: selected,
                onTap: () {
                  e['onTap']();
                  if (!selected) {
                    setState(() {
                      _index = i;
                    });
                  }
                },
              );
              if (selected) {
                tile.onTap!();
              }
              return tile;
            },).toList(),
          ),
        ),
        SizedBox(
          height: size.height,
          width: size.width-200,
          child: tabs[(_index >= 0) ? _index : 0]['widget'],
        ),
      ],
    );
  }

}