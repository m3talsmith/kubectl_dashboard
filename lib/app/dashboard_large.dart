import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:humanizer/humanizer.dart';
import 'package:kubectl_dashboard/app/auth.dart';
import 'package:kubectl_dashboard/app/config/providers.dart';
import 'package:kubectl_dashboard/app/dashboard/dashboard_list_tile.dart';
import 'package:kubectl_dashboard/app/dashboard/resources/providers.dart';
import 'package:kubectl_dashboard/app/dashboard/resources/resource_list.dart';
import 'package:kubectl_dashboard/app/preferences.dart';
import 'package:kuberneteslib/kuberneteslib.dart';
import 'package:shimmer/shimmer.dart';

class DashboardLarge extends ConsumerStatefulWidget {
  const DashboardLarge({this.contextIndex, super.key});

  final int? contextIndex;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DashboardLargeState();
}

class _DashboardLargeState extends ConsumerState<DashboardLarge> {
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

    final List<dynamic> subTabs = Resource.apiReadKinds
        .map(
          (e) => e.name,
        )
        .toList();

    return (config == null || authentication == null || currentContext == null)
        ? const Center(
            child: Shimmer(
                gradient: LinearGradient(
                    colors: [Colors.white10, Colors.transparent]),
                child: Text('Authenticating...')),
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
                    ...Resource.apiReadKinds.map(
                      (e) {
                        final selected =
                            subTabs.indexOf(e.name) == _subTabIndex;
                        if (selected) resourceKind = e.name;
                        return _SubTab(
                          title: SymbolName(e.name.toPluralForm())
                              .toHumanizedName()
                              .toTitleCase(),
                          resourceKind: e.name,
                          selected: selected,
                          onSelected: () {
                            final i = subTabs.indexOf(e.name);
                            if (i != _subTabIndex) {
                              setState(() {
                                _subTabIndex = i;
                              });
                            }
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: size.height,
                width: contentWidth,
                child: ResourcesList(kind: resourceKind),
              ),
            ],
          );
  }
}

class _SubTab extends ConsumerWidget {
  const _SubTab({
    required this.title,
    required this.resourceKind,
    this.selected = false,
    this.onSelected,
  });

  final String title;
  final String resourceKind;
  final bool selected;
  final Function()? onSelected;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.watch(authenticationProvider);
    return DashboardListTile(
        title: Text(title),
        selected: selected,
        onTap: () async {
          final resources = await Resource.list(
            auth: auth,
            resourceKind: resourceKind,
            namespace: null,
          );
          ref.watch(resourcesProvider.notifier).state = resources
            ..sort(
              (a, b) => a.metadata!.name!.compareTo(b.metadata!.name!),
            );
          if (!selected && onSelected != null) onSelected!();
        });
  }
}
