import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:humanizer/humanizer.dart';
import 'package:kubectl_dashboard/app/dashboard/resources/providers.dart';

import 'properties/condition.dart';
import 'properties/config_map.dart';
import 'properties/container.dart' as properties_container;
import 'properties/container_status.dart';
import 'properties/downward_api.dart';
import 'properties/field_ref.dart';
import 'properties/http_get.dart';
import 'properties/managed_field.dart';
import 'properties/owner_reference.dart';
import 'properties/port.dart';
import 'properties/probe.dart';
import 'properties/projected.dart';
import 'properties/rolling_update_strategy_type.dart';
import 'properties/security_context.dart';
import 'properties/selector.dart';
import 'properties/service_account_token.dart';
import 'properties/source.dart';
import 'properties/strategy.dart';
import 'properties/toleration.dart';
import 'properties/volume.dart' as properties_volume;

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
                  '${resource.kind.toTitleCase()}: ${resource.metadata.name!}'),
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
                      _FieldTile(
                          name: 'name', value: resource.metadata.name ?? ''),
                      if (resource.metadata.generateName != null)
                        _FieldTile(
                            name: 'generateName',
                            value: resource.metadata.generateName!),
                      _FieldTile(
                          name: 'namespace',
                          value: resource.metadata.namespace ?? ''),
                      _FieldTile(
                          name: 'uid', value: resource.metadata.uid ?? ''),
                      _FieldTile(
                          name: 'creationTimestamp',
                          value:
                              resource.metadata.creationTimestamp.toString()),
                      _FieldTile(
                          name: 'resourceVersion',
                          value: resource.metadata.resourceVersion ?? ''),
                      if (resource.metadata.labels.isNotEmpty)
                        Column(children: [
                          const _CategoryHeader(title: 'Labels'),
                          ...resource.metadata.labels.entries.map(
                            (e) => Tooltip(
                              message: '${e.value}',
                              child: Chip(
                                label: Text(e.key),
                              ),
                            ),
                          ),
                        ]),
                      if (resource.metadata.managedFields.isNotEmpty)
                        Column(children: [
                          const _CategoryHeader(title: 'Managed Fields'),
                          ...resource.metadata.managedFields
                              .map((e) => _ManagedField(field: e)),
                        ]),
                      if (resource.metadata.ownerReferences.isNotEmpty)
                        Column(children: [
                          const _CategoryHeader(title: 'Owner References'),
                          ...resource.metadata.ownerReferences
                              .map((e) => _OwnerReference(reference: e)),
                        ]),
                    ],
                  ),
                ),
                if (resource.spec != null)
                  SizedBox.fromSize(
                    size: columnSize,
                    child: ListView(
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'Spec',
                            textScaler: TextScaler.linear(2),
                          ),
                        ),
                        if (resource.spec!.nodeName != null)
                          _FieldTile(
                              name: 'nodeName',
                              value: resource.spec!.nodeName!),
                        if (resource.spec!.schedulerName != null)
                          _FieldTile(
                              name: 'schedulerName',
                              value: resource.spec!.schedulerName!),
                        if (resource.spec!.dnsPolicy != null)
                          _FieldTile(
                              name: 'dnsPolicy',
                              value: resource.spec!.dnsPolicy!),
                        if (resource.spec!.preemptionPolicy != null)
                          _FieldTile(
                              name: 'preemptionPolicy',
                              value: resource.spec!.preemptionPolicy!),
                        if (resource.spec!.restartPolicy != null)
                          _FieldTile(
                              name: 'restartPolicy',
                              value: resource.spec!.restartPolicy!),
                        if (resource.spec!.priority != null)
                          _FieldTile(
                              name: 'priority',
                              value: resource.spec!.priority!.toString()),
                        if (resource.spec!.serviceAccount != null)
                          _FieldTile(
                              name: 'serviceAccount',
                              value: resource.spec!.serviceAccount!),
                        if (resource.spec!.serviceAccountName != null)
                          _FieldTile(
                              name: 'serviceAccountName',
                              value: resource.spec!.serviceAccountName!),
                        if (resource.spec!.securityContext != null)
                          _SecurityContext(
                              securityContext: resource.spec!.securityContext!),
                        if (resource.spec!.terminationGracePeriodSeconds !=
                            null)
                          _FieldTile(
                              name: 'terminationGracePeriodSeconds',
                              value: resource
                                  .spec!.terminationGracePeriodSeconds
                                  .toString()),
                        if (resource.spec!.enableServiceLinks != null)
                          _FieldTile(
                              name: 'enableServiceLinks',
                              value:
                                  resource.spec!.enableServiceLinks.toString()),
                        if (resource.spec!.clusterIP != null)
                          _FieldTile(
                              name: 'clusterIP',
                              value: resource.spec!.clusterIP!),
                        if (resource.spec!.type != null)
                          _FieldTile(name: 'type', value: resource.spec!.type!),
                        if (resource.spec!.sessionAffinity != null)
                          _FieldTile(
                              name: 'sessionAffinity',
                              value: resource.spec!.sessionAffinity!),
                        if (resource.spec!.ipFamilyPolicy != null)
                          _FieldTile(
                              name: 'ipFamilyPolicy',
                              value: resource.spec!.ipFamilyPolicy!),
                        if (resource.spec!.internalTrafficPolicy != null)
                          _FieldTile(
                              name: 'internalTrafficPolicy',
                              value: resource.spec!.internalTrafficPolicy!),
                        if (resource.spec!.replicas != null)
                          _FieldTile(
                              name: 'replicas',
                              value: resource.spec!.replicas!.toString()),
                        if (resource.spec!.priorityClassName != null)
                          _FieldTile(
                              name: 'priorityClassName',
                              value: resource.spec!.priorityClassName!),
                        if (resource.spec!.strategy != null)
                          _Strategy(strategy: resource.spec!.strategy!),
                        if (resource.spec!.revisionHistoryLimit != null)
                          _FieldTile(
                              name: 'revisionHistoryLimit',
                              value: resource.spec!.revisionHistoryLimit!
                                  .toString()),
                        if (resource.spec!.progressDeadlineSeconds != null)
                          _FieldTile(
                              name: 'progressDeadlineSeconds',
                              value: resource.spec!.progressDeadlineSeconds!
                                  .toString()),
                        if (resource.spec!.tolerations.isNotEmpty)
                          Column(
                            children: [
                              const _CategoryHeader(
                                title: 'Tolerations',
                              ),
                              ...resource.spec!.tolerations.map(
                                (e) => _Toleration(toleration: e),
                              )
                            ],
                          ),
                        if (resource.spec!.nodeSelector.isNotEmpty)
                          Column(
                            children: [
                              const _CategoryHeader(title: 'Node Selector'),
                              Card(
                                child: Column(
                                  children: resource.spec!.nodeSelector.entries
                                      .map(
                                        (e) => _FieldTile(
                                            name: e.key, value: e.value),
                                      )
                                      .toList(),
                                ),
                              ),
                            ],
                          ),
                        if (resource.spec!.containers.isNotEmpty)
                          Column(
                            children: [
                              const _CategoryHeader(title: 'Containers'),
                              ...resource.spec!.containers.map(
                                (e) => _Container(container: e),
                              )
                            ],
                          ),
                        if (resource.spec!.volumes.isNotEmpty)
                          Column(
                            children: [
                              const _CategoryHeader(title: 'Volumes'),
                              ...resource.spec!.volumes.map(
                                (e) => _Volume(volume: e),
                              ),
                            ],
                          ),
                        if (resource.spec!.ports.isNotEmpty)
                          Column(
                            children: [
                              const _CategoryHeader(title: 'Ports'),
                              ...resource.spec!.ports.map(
                                (e) => _Port(
                                  port: e,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .surfaceContainerLow,
                                ),
                              ),
                            ],
                          ),
                        if (resource.spec!.clusterIPs.isNotEmpty)
                          Column(
                            children: [
                              const _CategoryHeader(title: 'Cluster IPs'),
                              ...resource.spec!.clusterIPs.map(
                                (e) => Tooltip(
                                  message: e,
                                  child: Chip(label: Text(e)),
                                ),
                              ),
                            ],
                          ),
                        if (resource.spec!.ipFamilies.isNotEmpty)
                          Column(
                            children: [
                              const _CategoryHeader(title: 'IP Families'),
                              ...resource.spec!.ipFamilies.map(
                                (e) => Tooltip(
                                  message: e,
                                  child: Chip(label: Text(e)),
                                ),
                              ),
                            ],
                          ),
                        if (resource.spec!.selector.entries.isNotEmpty)
                          Column(
                            children: [
                              const _CategoryHeader(title: 'Selector'),
                              ...resource.spec!.selector.values.map(
                                (e) => _Selector(selector: e),
                              ),
                            ],
                          )
                      ],
                    ),
                  ),
                if (resource.status != null)
                  SizedBox.fromSize(
                    size: columnSize,
                    child: ListView(
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'Status',
                            textScaler: TextScaler.linear(2),
                          ),
                        ),
                        if (resource.status!.phase != null)
                          _FieldTile(
                              name: 'phase', value: resource.status!.phase!),
                        if (resource.status!.startTime != null)
                          _FieldTile(
                              name: 'startTime',
                              value: resource.status!.startTime!.toString()),
                        if (resource.status!.qosClass != null)
                          _FieldTile(
                              name: 'qosClass',
                              value: resource.status!.qosClass!),
                        if (resource.status!.hostIP != null)
                          _FieldTile(
                              name: 'hostIP', value: resource.status!.hostIP!),
                        if (resource.status!.podIP != null) ...[
                          const Divider(),
                          _FieldTile(
                              name: 'podIP', value: resource.status!.podIP!),
                        ],
                        if (resource.status!.hostIPs.isNotEmpty)
                          Column(
                            children: [
                              const _CategoryHeader(title: 'Host IPs'),
                              ...resource.status!.hostIPs.map(
                                (e) {
                                  return Column(
                                    children: e.entries
                                        .map(
                                          (e) => Tooltip(
                                            message: e.value,
                                            child: Chip(label: Text(e.key)),
                                          ),
                                        )
                                        .toList(),
                                  );
                                },
                              ),
                            ],
                          ),
                        if (resource.status!.podIPs.isNotEmpty)
                          Column(
                            children: [
                              const _CategoryHeader(title: 'Pod IPs'),
                              ...resource.status!.podIPs.map(
                                (e) {
                                  return Column(
                                    children: e.entries
                                        .map(
                                          (e) => Tooltip(
                                            message: e.value,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Chip(label: Text(e.key)),
                                            ),
                                          ),
                                        )
                                        .toList(),
                                  );
                                },
                              ),
                            ],
                          ),
                        if (resource.status!.conditions.isNotEmpty)
                          Column(
                            children: [
                              const _CategoryHeader(title: 'Conditions'),
                              ...resource.status!.conditions.map(
                                (e) => _Condition(condition: e),
                              ),
                            ],
                          ),
                        if (resource.status!.containerStatuses.isNotEmpty)
                          Column(
                            children: [
                              const _CategoryHeader(
                                  title: 'Container Statuses'),
                              ...resource.status!.containerStatuses.map(
                                (e) => _ContainerStatus(containerStatus: e),
                              ),
                            ],
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

class _ManagedField extends StatelessWidget {
  const _ManagedField({required this.field});

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
  const _OwnerReference({required this.reference});

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

class _SecurityContext extends StatelessWidget {
  const _SecurityContext({required this.securityContext});

  final SecurityContext securityContext;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (securityContext.runAsNonRoot != null)
          _FieldTile(
              name: 'runAsNonRoot',
              value: securityContext.runAsNonRoot!.toString()),
        if (securityContext.allowPrivilegeEscalation != null)
          _FieldTile(
              name: 'allowPrivilegeEscalation',
              value: securityContext.allowPrivilegeEscalation!.toString()),
        if (securityContext.capabilities.isNotEmpty)
          const Card(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Capabilities',
                    textScaler: TextScaler.linear(1.2),
                  ),
                ),
              ],
            ),
          ),
        if (securityContext.seccompProfile.isNotEmpty)
          Card(
            child: Column(
              children: [
                const _CategoryHeader(title: 'seccomProfile'),
                ...securityContext.seccompProfile.entries.map(
                  (e) => _FieldTile(
                    name: e.key,
                    value: e.value,
                  ),
                ),
              ],
            ),
          )
      ],
    );
  }
}

class _Toleration extends StatelessWidget {
  const _Toleration({required this.toleration});

  final Toleration toleration;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          if (toleration.key != null)
            _FieldTile(name: 'time', value: toleration.key!),
          if (toleration.tolerationSeconds != null)
            _FieldTile(
                name: 'distance',
                value: toleration.tolerationSeconds!.toString()),
          if (toleration.effect != null)
            _FieldTile(name: 'velocity', value: toleration.effect!),
          if (toleration.operator != null)
            _FieldTile(name: 'operator', value: toleration.operator!)
        ],
      ),
    );
  }
}

class _Container extends StatelessWidget {
  const _Container({required this.container});

  final properties_container.Container container;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          _FieldTile(name: 'name', value: container.name),
          _FieldTile(name: 'image', value: container.image),
          _FieldTile(
              name: 'terminationMessagePath',
              value: container.terminationMessagePath),
          _FieldTile(
              name: 'terminationMessagePolicy',
              value: container.terminationMessagePolicy),
          _FieldTile(name: 'imagePullPolicy', value: container.imagePullPolicy),
          if (container.args.isNotEmpty)
            Column(
              children: [
                const _CategoryHeader(title: 'Args'),
                ...container.args.map(
                  (e) => Tooltip(message: e, child: Chip(label: Text(e))),
                ),
              ],
            ),
          if (container.ports.isNotEmpty)
            Column(
              children: [
                const _CategoryHeader(title: 'Ports'),
                ...container.ports.map(
                  (e) => _Port(port: e),
                ),
              ],
            ),
          if (container.livelinessProbe != null)
            Column(
              children: [
                const _CategoryHeader(title: 'Liveliness Probe'),
                _Probe(probe: container.livelinessProbe!),
              ],
            ),
          if (container.readinessProbe != null)
            Column(
              children: [
                const _CategoryHeader(title: 'Rediness Probe'),
                _Probe(probe: container.readinessProbe!),
              ],
            ),
          if (container.command.isNotEmpty)
            Card(
              child: Column(
                children: [
                  const _CategoryHeader(title: 'Command'),
                  ...container.command.map(
                    (e) => Tooltip(
                      message: e,
                      child: Chip(label: Text(e)),
                    ),
                  ),
                ],
              ),
            )
        ],
      ),
    );
  }
}

class _Port extends StatelessWidget {
  const _Port({required this.port, this.color});

  final Port port;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: color ?? Theme.of(context).canvasColor,
      child: Column(
        children: [
          _FieldTile(name: 'name', value: port.name ?? 'n/a'),
          _FieldTile(name: 'protocol', value: port.protocol ?? ''),
          _FieldTile(
              name: 'containerPort', value: port.containerPort.toString()),
        ],
      ),
    );
  }
}

class _Volume extends StatelessWidget {
  const _Volume({required this.volume});

  final properties_volume.Volume volume;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          if (volume.name != null)
            _FieldTile(name: 'name', value: volume.name!),
          if (volume.projected != null)
            Column(children: [
              const _CategoryHeader(title: 'Projected'),
              _Projected(projected: volume.projected!),
            ]),
        ],
      ),
    );
  }
}

class _Projected extends StatelessWidget {
  const _Projected({required this.projected});

  final Projected projected;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).canvasColor,
      child: Column(
        children: [
          if (projected.defaultMode != null)
            _FieldTile(
                name: 'defaultMode', value: projected.defaultMode!.toString()),
          if (projected.sources.isNotEmpty)
            Column(
              children: [
                const _CategoryHeader(title: 'Sources'),
                ...projected.sources.map(
                  (e) => _Source(source: e),
                )
              ],
            )
        ],
      ),
    );
  }
}

class _Source extends StatelessWidget {
  const _Source({required this.source});

  final Source source;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          if (source is ServiceAccountToken) ...[
            const _FieldTile(name: 'kind', value: 'serviceAccountToken'),
            _FieldTile(
                name: 'expirationSeconds',
                value: (source as ServiceAccountToken)
                    .expirationSeconds
                    .toString()),
            _FieldTile(
                name: 'path', value: (source as ServiceAccountToken).path),
          ],
          if (source is ConfigMap)
            Column(children: [
              const _FieldTile(name: 'kind', value: 'configMap'),
              _FieldTile(name: 'name', value: (source as ConfigMap).name),
              const _CategoryHeader(title: 'Items'),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: (source as ConfigMap)
                      .items
                      .map(
                        (e) => Tooltip(
                            message: e.path, child: Chip(label: Text(e.key))),
                      )
                      .toList(),
                ),
              )
            ]),
          if (source is DownwardAPI) ...[
            const _FieldTile(name: 'kind', value: 'downwardAPI'),
            const _CategoryHeader(title: 'Items'),
            ...(source as DownwardAPI).items.map(
                  (e) => _DownwardAPIItem(downwardAPIItem: e),
                ),
          ],
        ],
      ),
    );
  }
}

class _DownwardAPIItem extends StatelessWidget {
  const _DownwardAPIItem({required this.downwardAPIItem});

  final DownwardAPIItem downwardAPIItem;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).canvasColor,
      child: Column(
        children: [
          _FieldTile(name: 'path', value: downwardAPIItem.path),
          const _CategoryHeader(title: 'FieldRef'),
          _FieldRef(fieldRef: downwardAPIItem.fieldRef),
        ],
      ),
    );
  }
}

class _FieldRef extends StatelessWidget {
  const _FieldRef({required this.fieldRef});

  final FieldRef fieldRef;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (fieldRef.apiVersion != null)
          _FieldTile(name: 'apiVersion', value: fieldRef.apiVersion!),
        if (fieldRef.fieldPath != null)
          _FieldTile(name: 'fieldPath', value: fieldRef.fieldPath!),
      ],
    );
  }
}

class _Condition extends StatelessWidget {
  const _Condition({required this.condition});

  final Condition condition;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          _FieldTile(name: 'type', value: condition.type),
          _FieldTile(name: 'status', value: condition.status),
          if (condition.lastProbeTime != null)
            _FieldTile(
                name: 'lastProbeTime',
                value: condition.lastProbeTime!.toString()),
          if (condition.lastTransitionTime != null)
            _FieldTile(
                name: 'lastTransitionTime',
                value: condition.lastTransitionTime!.toString()),
          if (condition.lastUpdateTime != null)
            _FieldTile(
                name: 'lastUpdateTime',
                value: condition.lastUpdateTime!.toString()),
        ],
      ),
    );
  }
}

class _ContainerStatus extends StatelessWidget {
  const _ContainerStatus({required this.containerStatus});

  final ContainerStatus containerStatus;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          _FieldTile(name: 'name', value: containerStatus.name),
          if (containerStatus.running != null)
            _FieldTile(
                name: 'running', value: containerStatus.running!.toString()),
          if (containerStatus.restartCount != null)
            _FieldTile(
                name: 'restartCount',
                value: containerStatus.restartCount!.toString()),
          if (containerStatus.image != null)
            _FieldTile(name: 'image', value: containerStatus.image!),
          if (containerStatus.imageID != null)
            _FieldTile(name: 'imageID', value: containerStatus.imageID!),
          if (containerStatus.containerID != null)
            _FieldTile(
                name: 'containerID', value: containerStatus.containerID!),
          if (containerStatus.started != null)
            _FieldTile(
                name: 'started', value: containerStatus.started!.toString()),
          if (containerStatus.state.isNotEmpty)
            Column(
              children: [
                const _CategoryHeader(title: 'State'),
                ...containerStatus.state.entries.map(
                  (e) => Tooltip(
                    message: e.value.startedAt.toString(),
                    child: Chip(label: Text(e.key)),
                  ),
                ),
              ],
            ),
          if (containerStatus.lastState.isNotEmpty)
            Column(
              children: [
                const _CategoryHeader(title: 'Last State'),
                ...containerStatus.lastState.entries.map(
                  (e) => Tooltip(
                    message: e.value.startedAt.toString(),
                    child: Chip(label: Text(e.key)),
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}

class _Probe extends StatelessWidget {
  const _Probe({required this.probe});

  final Probe probe;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          if (probe.httpGet != null) _HttpGet(httpGet: probe.httpGet!),
          if (probe.initialDelaySeconds != null)
            _FieldTile(
                name: 'initialDelaySeconds',
                value: probe.initialDelaySeconds!.toString()),
          if (probe.timeoutSeconds != null)
            _FieldTile(
                name: 'timeoutSeconds',
                value: probe.timeoutSeconds!.toString()),
          if (probe.periodSeconds != null)
            _FieldTile(
                name: 'periodSeconds', value: probe.periodSeconds!.toString()),
          if (probe.successThreshold != null)
            _FieldTile(
                name: 'successThreshold',
                value: probe.successThreshold!.toString()),
          if (probe.failureThreshold != null)
            _FieldTile(
                name: 'failureThreshold',
                value: probe.failureThreshold!.toString()),
        ],
      ),
    );
  }
}

class _HttpGet extends StatelessWidget {
  const _HttpGet({required this.httpGet});

  final HttpGet httpGet;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (httpGet.path != null)
          _FieldTile(name: 'path', value: httpGet.path!),
        if (httpGet.port != null)
          _FieldTile(
            name: 'port',
            value: (httpGet.port is String?)
                ? httpGet.port
                : (httpGet.port as int).toString(),
          ),
        if (httpGet.scheme != null)
          _FieldTile(name: 'scheme', value: httpGet.scheme!),
      ],
    );
  }
}

class _Strategy extends StatelessWidget {
  const _Strategy({required this.strategy});

  final Strategy strategy;

  @override
  Widget build(BuildContext context) {
    Widget? details;
    switch (strategy.type) {
      case 'RollingUpdate':
        final e = (strategy.details as RollingUpdateStrategyType);
        details = Column(
          children: [
            if (e.maxUnavailable != null)
              _FieldTile(
                  name: 'maxUnavailable',
                  value: (e.maxUnavailable is String)
                      ? e.maxUnavailable
                      : e.maxUnavailable.toString()),
            if (e.maxSurge != null)
              _FieldTile(
                  name: 'maxSurge',
                  value: (e.maxSurge is String)
                      ? e.maxSurge
                      : e.maxSurge.toString()),
          ],
        );
    }

    return Card(
      child: Column(
        children: [
          _FieldTile(name: 'type', value: strategy.type),
          if (details != null) details,
        ],
      ),
    );
  }
}

class _Selector extends StatelessWidget {
  const _Selector({required this.selector});

  final Selector selector;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          _FieldTile(name: 'type', value: selector.type),
          ...selector.details.entries.map(
            (e) => Tooltip(
              message: e.key,
              child: Chip(label: Text(e.value)),
            ),
          ),
        ],
      ),
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
