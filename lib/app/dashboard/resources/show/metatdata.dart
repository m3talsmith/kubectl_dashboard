import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kuberneteslib/kuberneteslib.dart';

import '../providers.dart';

class MetadataPage extends ConsumerWidget {
  const MetadataPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final resource = ref.watch(currentResourceProvider);
    final metadata = resource?.metadata;
    log('metadata: ${metadata?.toJson()}');
    final size = MediaQuery.sizeOf(context);

    return metadata != null
        ? GridView.count(
            crossAxisCount: size.width ~/ 300,
            children: [
              if (metadata.annotations != null)
                _MetadataField(
                    name: 'Annotations',
                    value: metadata.annotations?.toString()),
              if (metadata.creationTimestamp != null)
                _MetadataField(
                    name: 'Creation Timestamp',
                    value: metadata.creationTimestamp),
              if (metadata.deletionGracePeriodSeconds != null)
                _MetadataField(
                    name: 'Deletion Grace Period Seconds',
                    value: metadata.deletionGracePeriodSeconds),
              if (metadata.deletionTimestamp != null)
                _MetadataField(
                    name: 'Deletion Timestamp',
                    value: metadata.deletionTimestamp),
              if (metadata.finalizers != null)
                _MetadataField(name: 'Finalizers', value: metadata.finalizers),
              if (metadata.generateName != null)
                _MetadataField(
                    name: 'Generate Name', value: metadata.generateName),
              if (metadata.generation != null)
                _MetadataField(name: 'Generation', value: metadata.generation),
              if (metadata.labels != null)
                _MetadataField(name: 'Labels', value: metadata.labels),
              if (metadata.managedFields != null)
                _MetadataField(
                    name: 'Managed Fields', value: metadata.managedFields),
              if (metadata.name != null)
                _MetadataField(name: 'Name', value: metadata.name),
              if (metadata.namespace != null)
                _MetadataField(name: 'Namespace', value: metadata.namespace),
              if (metadata.ownerReferences != null)
                _MetadataField(
                    name: 'Owner References', value: metadata.ownerReferences),
              if (metadata.resourceVersion != null)
                _MetadataField(
                    name: 'Resource Version', value: metadata.resourceVersion),
              if (metadata.selfLink != null)
                _MetadataField(name: 'Self Link', value: metadata.selfLink),
              if (metadata.uid != null)
                _MetadataField(name: 'Uid', value: metadata.uid),
            ],
          )
        : const Center(child: CircularProgressIndicator());
  }
}

class _MetadataField extends StatelessWidget {
  const _MetadataField({required this.name, required this.value});

  final String name;
  final dynamic value;

  @override
  Widget build(BuildContext context) {
    final textColor = Theme.of(context).colorScheme.onSecondaryContainer;
    final borderColor = Theme.of(context).colorScheme.primary;
    final containerColor = Theme.of(context).colorScheme.secondaryContainer;

    return value != null
        ? Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              margin: const EdgeInsets.all(8),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    _MetadataFieldHeader(name: name, color: textColor),
                    if (value is List<ManagedFieldEntry>)
                      ...value.map((e) => Column(children: [
                            ListTile(
                              title: Text('API Version',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(color: textColor)),
                              subtitle: Text(e.apiVersion,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(color: textColor)),
                            ),
                            ListTile(
                              title: Text('Fields Type',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(color: textColor)),
                              subtitle: Text(e.fieldsType,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(color: textColor)),
                            ),
                            ListTile(
                              title: Text('Manager',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(color: textColor)),
                              subtitle: Text(e.manager,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(color: textColor)),
                            ),
                            ListTile(
                              title: Text('Operation',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(color: textColor)),
                              subtitle: Text(e.operation,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(color: textColor)),
                            ),
                            if (e.subresource != null)
                              ListTile(
                                title: Text('Subresource',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(color: textColor)),
                                subtitle: Text(e.subresource,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(color: textColor)),
                              ),
                            ListTile(
                              title: Text('Time',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(color: textColor)),
                              subtitle: Text(e.time.toString(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(color: textColor)),
                            ),
                          ])),
                    if (value is String)
                      Text(value,
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: textColor,
                                  )),
                    if (value is DateTime)
                      Text(value.toString(),
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: textColor,
                                  )),
                    if (value is Map)
                      Text(value.toString(),
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: textColor,
                                  )),
                    if (value is bool)
                      Text(value.toString(),
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: textColor,
                                  )),
                    if (value is int)
                      Text(value.toString(),
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: textColor,
                                  )),
                    if (value is double)
                      Text(value.toString(),
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: textColor,
                                  )),
                  ],
                ),
              ),
            ),
          )
        : const SizedBox.shrink();
  }
}

class _MetadataFieldHeader extends StatelessWidget {
  const _MetadataFieldHeader({required this.name, required this.color});

  final String name;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Text(name,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(color: color));
  }
}
