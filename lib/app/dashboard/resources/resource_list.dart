import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kubectl_dashboard/app/dashboard/resources/providers.dart';
import 'package:kubectl_dashboard/app/dashboard/resources/resource_show.dart';

import '../resources.dart';

class ResourcesList extends ConsumerWidget {
  const ResourcesList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final resources = ref.watch(resourcesProvider);
    return GridView.count(
      crossAxisCount: 3,
      children: resources
          .map(
            (e) => SizedBox(
              width: 120,
              height: 120,
              child: InkWell(
                onTap: () async {
                  final nav = Navigator.of(context);
                  Resource? resource;
                  if (!Resource.ignoreShow
                      .contains(ResourceKind.fromString(e.kind))) {
                    resource = await Resource.show(
                      ref: ref,
                      resourceKind: e.kind,
                      resourceName: e.metadata.name!,
                      namespace: e.namespace,
                    );
                  }
                  resource = e;
                  ref.watch(currentResourceProvider.notifier).state = resource;
                  nav.push(
                    MaterialPageRoute(
                      builder: (context) => const ResourceShow(),
                    ),
                  );
                },
                child: Builder(builder: (context) {
                  final controller = MenuController();
                  return Card(
                    margin: const EdgeInsets.all(8.0),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(child: Container()),
                              MenuAnchor(
                                controller: controller,
                                menuChildren: [
                                  MenuItemButton(
                                    onPressed: () {
                                      e.delete(ref: ref);
                                      ref
                                          .watch(resourcesProvider.notifier)
                                          .state = resources..remove(e);
                                    },
                                    child: const ListTile(
                                      title: Text('Delete'),
                                    ),
                                  )
                                ],
                                child: IconButton(
                                    onPressed: () => (controller.isOpen)
                                        ? controller.close()
                                        : controller.open(),
                                    icon: const Icon(Icons.more_vert_rounded)),
                              ),
                            ],
                          ),
                          Text(e.metadata.namespace ?? 'default'),
                          if (e.status != null)
                            Expanded(
                              child: Center(
                                child: (e.status!.phase != null)
                                    ? Container(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .inversePrimary,
                                        child: Padding(
                                          padding: const EdgeInsets.all(16.0),
                                          child: Text(e.status!.phase!),
                                        ),
                                      )
                                    : Container(),
                              ),
                            ),
                          Text(e.metadata.name ?? 'unknown'),
                        ],
                      ),
                    ),
                  );
                }),
              ),
            ),
          )
          .toList(),
    );
  }
}
