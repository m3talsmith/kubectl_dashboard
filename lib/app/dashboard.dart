import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kubectl_dashboard/app/config.dart';
import 'package:kubectl_dashboard/app/dashboard/dashboard_list_tile.dart';

class DashboardView extends ConsumerStatefulWidget {
  const DashboardView({required this.config, super.key});

  final Config config;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DashboardViewState();

}

class _DashboardViewState extends ConsumerState<DashboardView> {

  int _index = 0;

  final List<Map<String, dynamic>> _tabs = [
    {
      'title': 'Deployments',
      'onTap': () {}
    },
    {
      'title': 'Pods',
      'onTap': () {}
    },
    {
      'title': 'Ingresses',
      'onTap': () {}
    },
    {
      'title': 'Certificates',
      'onTap': () {}
    },
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Row(
      children: [
        Container(
          // color: Theme.of(context).primaryColor,
          height: size.height,
          width: 200,
          child: ListView(
            shrinkWrap: true,
            children: _tabs.map((e) {
              final i = _tabs.indexOf(e);
              final selected = i == _index;
              return DashboardListTile(
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
            },).toList(),
          ),
        ),
        Container(
          height: size.height,
          width: size.width-200,
          child: ListView(
            shrinkWrap: true,
            // children: [],
          ),
        ),
      ],
    );
  }

}