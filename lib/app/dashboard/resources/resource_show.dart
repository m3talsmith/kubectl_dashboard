import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:humanizer/humanizer.dart';
import 'package:kubectl_dashboard/app/dashboard/resources/providers.dart';

class ResourceShow extends ConsumerWidget {
  const ResourceShow({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final resource = ref.watch(currentResourceProvider);
    final size = MediaQuery.of(context).size;
    final columnSize = Size(size.width / 3, size.height);

    return Scaffold(
      appBar: resource != null
          ? AppBar(
              centerTitle: true,
              title: Text(
                  '${resource.kind!.toTitleCase()}: ${resource.metadata!.name}'),
            )
          : null,
      body: resource != null
          ? Row(
              children: [
                SizedBox.fromSize(
                  size: columnSize,
                  child: ListView(
                    shrinkWrap: true,
                    children: const [
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Metadata',
                          textScaler: TextScaler.linear(2),
                        ),
                      ),
                    ],
                  ),
                ),
                if (resource.spec != null)
                  SizedBox.fromSize(
                    size: columnSize,
                    child: ListView(
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
                  ),
                if (resource.status != null)
                  SizedBox.fromSize(
                    size: columnSize,
                    child: ListView(
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

class _FieldTile extends StatelessWidget {
  const _FieldTile({required this.name, required this.value});

  final String name;
  final String value;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(name),
      subtitle: Text(value),
    );
  }
}

class _CategoryHeader extends StatelessWidget {
  const _CategoryHeader({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      const Divider(),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          title,
          textScaler: const TextScaler.linear(1.5),
        ),
      ),
    ]);
  }
}
