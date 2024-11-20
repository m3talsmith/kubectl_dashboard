import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kubectl_dashboard/app/dashboard/resources/providers.dart';
import 'package:kubectl_dashboard/app/dashboard/resources/resource-show.dart';

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
                onTap: () {
                  ref.watch(currentResourceProvider.notifier).state = e;
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ResourceShow(),
                    ),
                  );
                },
                child: Card(
                  margin: const EdgeInsets.all(8.0),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Text(e.metadata?.namespace ?? 'default'),
                        Expanded(
                          child: Center(
                            child: (e.status?.phase != null)
                                ? Container(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .inversePrimary,
                                    child: Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Text(e.status!.phase!),
                                    ),
                                  )
                                : null,
                          ),
                        ),
                        Text(e.metadata?.name ?? 'unknown'),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}
