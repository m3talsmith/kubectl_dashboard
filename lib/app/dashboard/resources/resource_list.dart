import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:humanizer/humanizer.dart';
import 'package:kubectl_dashboard/app/auth.dart';
import 'package:kubectl_dashboard/app/dashboard/resources/providers.dart';
import 'package:kubectl_dashboard/app/dashboard/resources/resource_show.dart';
import 'package:kuberneteslib/kuberneteslib.dart';

class ResourcesList extends ConsumerWidget {
  const ResourcesList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final resources = ref.watch(resourcesProvider);
    final resourceKind = resources.first.kind;
    final auth = ref.watch(authenticationProvider);
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton.icon(
              onPressed: () {},
              label: Text(
                  SymbolName(resourceKind).toHumanizedName().toTitleCase()),
              icon: const Icon(Icons.add_rounded),
            ),
          ),
        ],
      ),
      body: GridView.count(
        crossAxisCount: 3,
        shrinkWrap: true,
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
                        auth: auth,
                        resourceKind: e.kind,
                        resourceName: e.metadata.name,
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
                                        e.delete();
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
                                      icon:
                                          const Icon(Icons.more_vert_rounded)),
                                ),
                              ],
                            ),
                            Text(e.metadata.namespace ?? 'default'),
                            if (e.status != null)
                              Expanded(
                                child: Center(
                                  child: Container(),
                                ),
                              ),
                            Text(e.metadata.name),
                          ],
                        ),
                      ),
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
