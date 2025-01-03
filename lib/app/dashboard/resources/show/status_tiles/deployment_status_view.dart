import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:kuberneteslib/kuberneteslib.dart';

class DeploymentStatusView extends StatelessWidget {
  const DeploymentStatusView({super.key, required this.status});

  final DeploymentStatus status;

  @override
  Widget build(BuildContext context) {
    log('[DeploymentStatusView] status: ${status.toJson()}');
    final size = MediaQuery.sizeOf(context);
    return StaggeredGrid.count(
      crossAxisCount: size.width ~/ 300,
      children: [
                  if(status.availableReplicas != null)
            DeploymentStatusField(name: 'Available Replicas', value: status.availableReplicas),

			          if(status.collisionCount != null)
            DeploymentStatusField(name: 'Collision Count', value: status.collisionCount),

			          if(status.conditions != null)
            ...?status.conditions?.map((e) => Card(child: Padding(padding: const EdgeInsets.all(8.0), child: Column(children: [
            const DeploymentStatusFieldHeader(name: 'Deployment Condition'),
                            if(e.lastTransitionTime != null)
                DeploymentStatusField(name: 'Last Transition Time', value: e.lastTransitionTime, color: Theme.of(context).colorScheme.surface)
,
              if(e.lastUpdateTime != null)
                DeploymentStatusField(name: 'Last Update Time', value: e.lastUpdateTime, color: Theme.of(context).colorScheme.surface)
,
              if(e.message != null)
                DeploymentStatusField(name: 'Message', value: e.message, color: Theme.of(context).colorScheme.surface)
,
              if(e.reason != null)
                DeploymentStatusField(name: 'Reason', value: e.reason, color: Theme.of(context).colorScheme.surface)
,
              if(e.status != null)
                DeploymentStatusField(name: 'Status', value: e.status, color: Theme.of(context).colorScheme.surface)
,
              if(e.type != null)
                DeploymentStatusField(name: 'Type', value: e.type, color: Theme.of(context).colorScheme.surface)

          ])))),

			          if(status.observedGeneration != null)
            DeploymentStatusField(name: 'Observed Generation', value: status.observedGeneration),

			          if(status.readyReplicas != null)
            DeploymentStatusField(name: 'Ready Replicas', value: status.readyReplicas),

			          if(status.replicas != null)
            DeploymentStatusField(name: 'Replicas', value: status.replicas),

			          if(status.unavailableReplicas != null)
            DeploymentStatusField(name: 'Unavailable Replicas', value: status.unavailableReplicas),

			          if(status.updatedReplicas != null)
            DeploymentStatusField(name: 'Updated Replicas', value: status.updatedReplicas),

      ],
    );
  }
}

class DeploymentStatusFieldHeader extends StatelessWidget {
  const DeploymentStatusFieldHeader({super.key, required this.name, this.color});

  final String name;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Text(name, style: Theme.of(context).textTheme.titleMedium?.copyWith(color: color));
  }
}

class DeploymentStatusField extends StatelessWidget {
  const DeploymentStatusField({super.key, required this.name, required this.value, this.color, this.textColor});

  final String name;
  final dynamic value;
  final Color? color;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    Widget valueWidget;
    switch (value) {
      case List<dynamic> list:
        valueWidget = Column(
          children: list.map((e) => Text(e.toString(), style: Theme.of(context).textTheme.bodySmall?.copyWith(color: textColor))).toList(),
        );
      case Map<String, dynamic> map:
        valueWidget = Column(
          children: map.entries.map((e) => Text('${e.key}: ${e.value}', style: Theme.of(context).textTheme.bodySmall?.copyWith(color: textColor))).toList(),
        );
      default:
        valueWidget = Text(value.toString(), style: Theme.of(context).textTheme.bodySmall?.copyWith(color: textColor));
    }
    return Card(
      color: color,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            DeploymentStatusFieldHeader(name: name, color: textColor),
            valueWidget,
          ],
        ),
      ),
    );
  }
}
