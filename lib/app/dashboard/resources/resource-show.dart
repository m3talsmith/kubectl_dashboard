import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kubectl_dashboard/app/dashboard/resources/providers.dart';

class ResourceShow extends ConsumerWidget {
  const ResourceShow({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final resource = ref.watch(currentResourceProvider);
    return Scaffold(
      appBar: resource != null
          ? AppBar(
              centerTitle: true,
              title: Text(resource.metadata.name),
            )
          : null,
      body: resource != null
          ? GridView.count(
              crossAxisCount: 3,
              children: [
                ListView(
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Metadata',
                        textScaler: TextScaler.linear(2),
                      ),
                    ),
                    Text('name: ${resource.metadata.name}'),
                    Text('generateName: ${resource.metadata.generateName}'),
                    Text('namespace: ${resource.metadata.namespace}'),
                    Text('uid: ${resource.metadata.uid}'),
                    Text(
                        'creationTimestamp: ${resource.metadata.creationTimestamp}'),
                    Text(
                        'resourceVersion: ${resource.metadata.resourceVersion}'),
                  ],
                ),
                ListView(
                  children: const [
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Spec',
                        textScaler: TextScaler.linear(2),
                      ),
                    ),
                  ],
                ),
                ListView(
                  children: const [
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Status',
                        textScaler: TextScaler.linear(2),
                      ),
                    ),
                  ],
                ),
              ],
            )
          : const Center(
              child: Column(
                children: [
                  LinearProgressIndicator(),
                  Text('Loading...'),
                ],
              ),
            ),
    );
  }
}
