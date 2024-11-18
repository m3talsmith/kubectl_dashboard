import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kubectl_dashboard/app/dashboard/resources/providers.dart';

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
              child: Card(
                margin: const EdgeInsets.all(8.0),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      const Expanded(child: Icon(Icons.data_usage_rounded)),
                      Text(e.metadata.name ?? 'unknown')
                    ],
                  ),
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}
