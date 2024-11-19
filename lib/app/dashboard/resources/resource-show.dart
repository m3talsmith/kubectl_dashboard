import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kubectl_dashboard/app/dashboard/resources/properties.dart';
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
              title: Text(resource.metadata.name),
            )
          : null,
      body: resource != null
          ? Row(
              children: [
                SizedBox.fromSize(
                  size: columnSize,
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Metadata',
                          textScaler: TextScaler.linear(2),
                        ),
                      ),
                      _FieldTile(name: 'name', value: resource.metadata.name),
                      if (resource.metadata.generateName != null)
                        _FieldTile(
                            name: 'generateName',
                            value: resource.metadata.generateName!),
                      _FieldTile(
                          name: 'namespace',
                          value: resource.metadata.namespace),
                      _FieldTile(name: 'uid', value: resource.metadata.uid),
                      _FieldTile(
                          name: 'creationTimestamp',
                          value:
                              resource.metadata.creationTimestamp.toString()),
                      _FieldTile(
                          name: 'resourceVersion',
                          value: resource.metadata.resourceVersion),
                      const Padding(
                        padding: EdgeInsets.only(left: 8.0),
                        child: Text(
                          'Labels',
                          textScaler: TextScaler.linear(1.5),
                        ),
                      ),
                      GridView.count(
                        crossAxisCount: 3,
                        shrinkWrap: true,
                        children: resource.metadata.labels?.entries
                                .map(
                                  (e) => Tooltip(
                                    message: '${e.value}',
                                    child: Chip(
                                      label: Text(e.key),
                                    ),
                                  ),
                                )
                                .toList() ??
                            [],
                      ),
                      if (resource.metadata.managedFields != null) ...[
                        const Padding(
                          padding: EdgeInsets.only(left: 8.0),
                          child: Text(
                            'Managed Fields',
                            textScaler: TextScaler.linear(1.5),
                          ),
                        ),
                        ...resource.metadata.managedFields!
                            .map((e) => _ManagedField(field: e)),
                      ],
                      if (resource.metadata.ownerReferences != null &&
                          resource.metadata.ownerReferences!.isNotEmpty) ...[
                        const Padding(
                          padding: EdgeInsets.only(left: 8.0),
                          child: Text(
                            'Owner References',
                            textScaler: TextScaler.linear(1.5),
                          ),
                        ),
                        ...resource.metadata.ownerReferences!
                            .map((e) => _OwnerReference(reference: e)),
                      ],
                    ],
                  ),
                ),
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
  const _FieldTile({required this.name, required this.value, super.key});

  final String name;
  final String value;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(value),
      subtitle: Text(name),
    );
  }
}

class _ManagedField extends StatelessWidget {
  const _ManagedField({required this.field, super.key});

  final ManagedField field;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          _FieldTile(name: 'apiVersion', value: field.apiVersion),
          _FieldTile(name: 'manager', value: field.manager),
          _FieldTile(name: 'operation', value: field.operation),
          if (field.subresource.isNotEmpty)
            _FieldTile(name: 'subresource', value: field.subresource),
          _FieldTile(name: 'time', value: field.time.toString()),
        ],
      ),
    );
  }
}

class _OwnerReference extends StatelessWidget {
  const _OwnerReference({required this.reference, super.key});

  final OwnerReference reference;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          _FieldTile(name: 'apiVersion', value: reference.apiVersion),
          _FieldTile(name: 'name', value: reference.name),
          _FieldTile(name: 'uid', value: reference.uid),
          _FieldTile(name: 'kind', value: reference.kind),
          _FieldTile(
              name: 'blockOwnerDeletion',
              value: reference.blockOwnerDeletion.toString()),
          _FieldTile(
              name: 'controller', value: reference.controller.toString()),
        ],
      ),
    );
  }
}
