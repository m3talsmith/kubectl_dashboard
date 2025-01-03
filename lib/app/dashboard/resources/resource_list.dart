import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:humanizer/humanizer.dart';
import 'package:kubectl_dashboard/app/auth.dart';
import 'package:kubectl_dashboard/app/dashboard/resources/providers.dart';
import 'package:kubectl_dashboard/app/dashboard/resources/resource_add.dart';
import 'package:kubectl_dashboard/app/dashboard/resources/resource_show.dart';
import 'package:kuberneteslib/kuberneteslib.dart';

class ResourcesList extends ConsumerWidget {
  const ResourcesList({required this.kind, super.key});

  final String kind;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final resources = ref.watch(resourcesProvider);
    final auth = ref.watch(authenticationProvider);
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton.icon(
              onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => ResourceAdd(kind: kind),
              )),
              label: Text(SymbolName(kind).toHumanizedName().toTitleCase()),
              icon: const Icon(Icons.add_rounded),
            ),
          ),
        ],
      ),
      body: ListView(
        children: resources
            .map(
              (e) => Card(
                child: InkWell(
                  onTap: () async {
                    final nav = Navigator.of(context);
                    Resource? resource;
                    if (!Resource.ignoreShow
                        .contains(ResourceKind.fromString(e.kind!))) {
                      resource = await Resource.show(
                        auth: auth,
                        resourceKind: e.kind!,
                        resourceName: e.metadata!.name!,
                        namespace: e.namespace,
                      );
                    }
                    resource = e;
                    ref.watch(currentResourceProvider.notifier).state =
                        resource;
                    nav.push(
                      MaterialPageRoute(
                        builder: (context) => const ResourceShow(),
                      ),
                    );
                  },
                  child: Builder(builder: (context) {
                    final controller = MenuController();
                    return Stack(
                      alignment: Alignment.center,
                      children: [
                        Positioned(
                          right: 0,
                          top: 0,
                          child: MenuAnchor(
                            controller: controller,
                            menuChildren: [
                              MenuItemButton(
                                onPressed: () async {
                                  await e.delete();
                                  ref.watch(resourcesProvider.notifier).state =
                                      resources..remove(e);
                                },
                                child: const ListTile(
                                  title: Text('Delete'),
                                ),
                              )
                            ],
                            builder: (context, controller, child) => IconButton(
                              onPressed: () => (controller.isOpen)
                                  ? controller.close()
                                  : controller.open(),
                              icon: const Icon(Icons.more_vert_rounded),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                e.metadata?.namespace ?? 'default',
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                              Text(e.metadata!.name!),
                            ],
                          ),
                        )
                      ],
                    );
                  }),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
