import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kubectl_dashboard/app/auth.dart';
import 'package:kubectl_dashboard/app/config/providers.dart';
import 'package:kubectl_dashboard/app/dashboard/dashboard_list_tile.dart';
import 'package:kubectl_dashboard/app/dashboard/resources/pods/pods_list.dart';
import 'package:kubectl_dashboard/app/dashboard/resources/pods/providers.dart';
import 'package:kubectl_dashboard/app/preferences.dart';

import 'dashboard/resources/pods.dart';

class DashboardView extends ConsumerStatefulWidget {
  const DashboardView({this.contextIndex, super.key});

  final int? contextIndex;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DashboardViewState();
}

class _DashboardViewState extends ConsumerState<DashboardView> {
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

    final size = MediaQuery.of(context).size;
    const double tabsWidth = 280;
    const double subTabsWidth = 200;
    final double contentWidth = size.width - (tabsWidth + subTabsWidth);

    final List<Map<String, dynamic>> tabs = config?.contexts
            .map(
              (e) => {
                'title': e.name,
                'onTap': () {
                  final index = config.contexts.indexOf(e);
                  ref.watch(currentContextIndexProvider.notifier).state = index;
                  ref.watch(currentContextProvider.notifier).state = e;
                  ref
                      .watch(preferencesProvider.notifier)
                      .state
                      ?.currentContextIndex = index;
                },
              },
            )
            .toList() ??
        [];

    final List<Map<String, dynamic>> subTabs = [
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
        'widget': const Center(
          child: Text('Services'),
        ),
      },
      {
        'title': 'Deployments',
        'onTap': () {},
        'widget': const Center(
          child: Text('Deployments'),
        ),
      },
      {
        'title': 'Ingresses',
        'onTap': () {},
        'widget': const Center(
          child: Text('Ingresses'),
        ),
      },
      {
        'title': 'Certificates',
        'onTap': () {},
        'widget': const Center(
          child: Text('Certificates'),
        ),
      },
    ];

    return (config == null || authentication == null || currentContext == null)
        ? const Center(
            child: Text('Authenticating...'),
          )
        : Row(
            children: [
              SizedBox(
                height: size.height,
                width: tabsWidth,
                child: ListView(
                  shrinkWrap: true,
                  children: tabs.map(
                    (e) {
                      final i = tabs.indexOf(e);
                      final selected = i == _tabIndex;
                      final tile = DashboardListTile(
                        title: Text(e['title']),
                        selected: selected,
                        shape: const ContinuousRectangleBorder(),
                        onTap: () {
                          e['onTap']();
                          if (!selected) {
                            setState(() {
                              _tabIndex = i;
                            });
                          }
                        },
                      );
                      return tile;
                    },
                  ).toList(),
                ),
              ),
              SizedBox(
                height: size.height,
                width: subTabsWidth,
                child: ListView(
                  shrinkWrap: true,
                  children: subTabs.map(
                    (e) {
                      final i = subTabs.indexOf(e);
                      final selected = i == _subTabIndex;
                      final tile = DashboardListTile(
                        title: Text(e['title']),
                        selected: selected,
                        onTap: () {
                          e['onTap']();
                          if (!selected) {
                            setState(() {
                              _subTabIndex = i;
                            });
                          }
                        },
                      );
                      if (selected) {
                        tile.onTap!();
                      }
                      return tile;
                    },
                  ).toList(),
                ),
              ),
              SizedBox(
                height: size.height,
                width: contentWidth,
                child: subTabs[(_subTabIndex >= 0) ? _subTabIndex : 0]
                    ['widget'],
              ),
            ],
          );
  }
}
