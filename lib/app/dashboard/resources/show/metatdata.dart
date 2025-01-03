import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kuberneteslib/kuberneteslib.dart';

import '../providers.dart';

class MetadataPage extends ConsumerWidget {
  const MetadataPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final resource = ref.watch(currentResourceProvider);
    final metadata = resource?.metadata;
    final size = MediaQuery.sizeOf(context);
    if (metadata == null) {
      return const SizedBox.shrink();
    }

    return StaggeredGrid.count(
      crossAxisCount: size.width ~/ 300,
      children: [
        _MetadataField(
            name: 'Annotations', value: metadata.annotations?.toString()),
        _MetadataField(
            name: 'Creation Timestamp', value: metadata.creationTimestamp),
        _MetadataField(
            name: 'Deletion Grace Period Seconds',
            value: metadata.deletionGracePeriodSeconds),
        _MetadataField(
            name: 'Deletion Timestamp', value: metadata.deletionTimestamp),
        _MetadataField(name: 'Finalizers', value: metadata.finalizers),
        _MetadataField(name: 'Generate Name', value: metadata.generateName),
        _MetadataField(name: 'Generation', value: metadata.generation),
        _MetadataField(name: 'Labels', value: metadata.labels),
        _MetadataField(name: 'Managed Fields', value: metadata.managedFields),
        _MetadataField(name: 'Name', value: metadata.name),
        _MetadataField(name: 'Namespace', value: metadata.namespace),
        _MetadataField(
            name: 'Owner References', value: metadata.ownerReferences),
        _MetadataField(
            name: 'Resource Version', value: metadata.resourceVersion),
        _MetadataField(name: 'Self Link', value: metadata.selfLink),
        _MetadataField(name: 'Uid', value: metadata.uid),
      ],
    );
  }
}

class _MetadataField extends StatelessWidget {
  const _MetadataField({required this.name, required this.value});

  final String name;
  final dynamic value;

  @override
  Widget build(BuildContext context) {
    if (this.value == null) {
      return const SizedBox.shrink();
    }
    var value = this.value;
    if (value is String) {
      if (value.contains('{')) {
        value = _MetadataFieldMap.decode(value);
      }
    }
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        margin: const EdgeInsets.all(8),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              _MetadataFieldHeader(name: name),
              if (value is List<ManagedFieldEntry>)
                ...value.map((e) => Column(children: [
                      _ManagedFieldEntry(entry: e),
                    ])),
              if (value is Map) _MetadataFieldMap(value: value),
              if (value is String)
                Text(value, style: Theme.of(context).textTheme.bodySmall),
              if (value is DateTime)
                Text(value.toString(),
                    style: Theme.of(context).textTheme.bodySmall),
              if (value is bool)
                Text(value.toString(),
                    style: Theme.of(context).textTheme.bodySmall),
              if (value is int)
                Text(value.toString(),
                    style: Theme.of(context).textTheme.bodySmall),
              if (value is double)
                Text(value.toString(),
                    style: Theme.of(context).textTheme.bodySmall),
            ],
          ),
        ),
      ),
    );
  }
}

class _MetadataFieldHeader extends StatelessWidget {
  const _MetadataFieldHeader({required this.name});

  final String name;

  @override
  Widget build(BuildContext context) {
    return Text(name, style: Theme.of(context).textTheme.titleMedium);
  }
}

class _MetadataFieldMap extends StatelessWidget {
  const _MetadataFieldMap({required this.value});

  final Map value;

  static Map<String, dynamic> decode(String value) {
    final parts = value.split(',');
    final map = <String, dynamic>{};
    for (var part in parts) {
      final keyValue = part.split(':');
      final key = keyValue[0].replaceAll('{', '');
      final value = keyValue[1].contains('{')
          ? _MetadataFieldMap.decode(keyValue[1])
          : keyValue[1];
      map[key] = (value is String)
          ? value.replaceAll('{', '').replaceAll('}', '')
          : value;
    }
    return map;
  }

  @override
  Widget build(BuildContext context) {
    final widgets = <Widget>[];
    for (var entry in value.entries) {
      if (entry.value is! Map) {
        widgets.add(ListTile(
          title: Text(entry.key.toString(),
              style: Theme.of(context).textTheme.bodyLarge),
          subtitle: Text(entry.value.toString(),
              style: Theme.of(context).textTheme.bodySmall),
        ));
      }
      if (entry.value is Map) {
        if (entry.value.isNotEmpty) {
          widgets.add(_MetadataFieldMap(value: entry.value));
        }
      }
    }
    return Column(children: widgets.toList());
  }
}

class _ManagedFieldEntry extends StatelessWidget {
  const _ManagedFieldEntry({required this.entry});

  final ManagedFieldEntry entry;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      if (entry.apiVersion != null)
        ListTile(
          title:
              Text('API Version', style: Theme.of(context).textTheme.bodyLarge),
          subtitle: Text(entry.apiVersion!,
              style: Theme.of(context).textTheme.bodySmall),
        ),
      if (entry.manager != null)
        ListTile(
          title: Text('Manager', style: Theme.of(context).textTheme.bodyLarge),
          subtitle: Text(entry.manager!,
              style: Theme.of(context).textTheme.bodySmall),
        ),
      if (entry.operation != null)
        ListTile(
          title:
              Text('Operation', style: Theme.of(context).textTheme.bodyLarge),
          subtitle: Text(entry.operation!,
              style: Theme.of(context).textTheme.bodySmall),
        ),
      if (entry.subresource != null)
        ListTile(
          title:
              Text('Subresource', style: Theme.of(context).textTheme.bodyLarge),
          subtitle: Text(entry.subresource!,
              style: Theme.of(context).textTheme.bodySmall),
        ),
      if (entry.time != null)
        ListTile(
          title: Text('Time', style: Theme.of(context).textTheme.bodyLarge),
          subtitle: Text(entry.time!.toString(),
              style: Theme.of(context).textTheme.bodySmall),
        ),
    ]);
  }
}
