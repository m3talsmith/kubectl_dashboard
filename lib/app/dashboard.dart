import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kubectl_dashboard/app/auth.dart';
import 'package:kubectl_dashboard/app/config/providers.dart';
import 'package:kubectl_dashboard/app/dashboard/dashboard_list_tile.dart';
import 'package:kubectl_dashboard/app/dashboard/resources.dart';
import 'package:kubectl_dashboard/app/dashboard/resources/providers.dart';
import 'package:kubectl_dashboard/app/dashboard/resources/resource-list.dart';
import 'package:kubectl_dashboard/app/preferences.dart';
import 'package:pluralize/pluralize.dart';

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

    final List<dynamic> subTabs = [
      'Pods',
      'Services',
      'Deployments',
      'Ingresses',
      'Certificates',
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
                  children: [
                    _SubTab(
                      title: 'Pods',
                      selected: subTabs.indexOf('Pods') == _subTabIndex,
                      onSelected: () {
                        final i = subTabs.indexOf('Pods');
                        if (i != _subTabIndex) {
                          setState(() {
                            _subTabIndex = i;
                          });
                        }
                      },
                    ),
                    _SubTab(
                      title: 'Services',
                      selected: subTabs.indexOf('Services') == _subTabIndex,
                      onSelected: () {
                        final i = subTabs.indexOf('Services');
                        if (i != _subTabIndex) {
                          setState(() {
                            _subTabIndex = i;
                          });
                        }
                      },
                    ),
                    _SubTab(
                      title: 'Deployments',
                      api: '/apis/apps/v1',
                      selected: subTabs.indexOf('Deployments') == _subTabIndex,
                      onSelected: () {
                        final i = subTabs.indexOf('Deployments');
                        if (i != _subTabIndex) {
                          setState(() {
                            _subTabIndex = i;
                          });
                        }
                      },
                    )
                  ],
                ),
              ),
              SizedBox(
                height: size.height,
                width: contentWidth,
                child: const ResourcesList(),
              ),
            ],
          );
  }
}

class _SubTab extends ConsumerWidget {
  const _SubTab({
    required this.title,
    this.resource,
    this.pluralize = true,
    this.downcase = true,
    this.selected = false,
    this.onSelected,
    this.api,
  });

  final String title;
  final String? resource;
  final bool pluralize;
  final bool downcase;
  final bool selected;
  final Function()? onSelected;
  final String? api;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String resourceName = (resource == null) ? title : resource!;
    if (pluralize) resourceName = Pluralize().pluralize(resourceName, 3, false);
    if (downcase) resourceName = resourceName.toLowerCase();
    return DashboardListTile(
        title: Text(title),
        selected: selected,
        onTap: () async {
          final resources = await Resource.list(
            ref: ref,
            resource: resourceName,
            api: api,
          );
          ref.watch(resourcesProvider.notifier).state = resources;
          if (!selected && onSelected != null) onSelected!();
        });
  }
}
