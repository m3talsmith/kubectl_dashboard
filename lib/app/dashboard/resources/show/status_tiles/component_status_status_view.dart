import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:kuberneteslib/kuberneteslib.dart';

class ComponentStatusStatusView extends StatelessWidget {
  const ComponentStatusStatusView({super.key, required this.status});

  final ComponentStatusStatus status;

  @override
  Widget build(BuildContext context) {
    log('[ComponentStatusStatusView] status: ${status.toJson()}');
    final size = MediaQuery.sizeOf(context);
    return StaggeredGrid.count(
      crossAxisCount: size.width ~/ 300,
      children: [
                  if(status.apiVersion != null)
            ComponentStatusStatusField(name: 'Api Version', value: status.apiVersion),

			          if(status.items != null)
            ...?status.items?.map((e) => Card(child: Padding(padding: const EdgeInsets.all(8.0), child: Column(children: [
            const ComponentStatusStatusFieldHeader(name: 'Component Status'),
                            if(e.apiVersion != null)
                ComponentStatusStatusField(name: 'Api Version', value: e.apiVersion, color: Theme.of(context).colorScheme.surface)
,
              if(e.kind != null)
                ComponentStatusStatusField(name: 'Kind', value: e.kind, color: Theme.of(context).colorScheme.surface)
,
              if(e.metadata != null)
                ComponentStatusStatusField(name: 'Metadata', value: e.metadata, color: Theme.of(context).colorScheme.surface)

          ])))),

			          if(status.kind != null)
            ComponentStatusStatusField(name: 'Kind', value: status.kind),

			          if(status.metadata != null)
            Card(child: Padding(padding: const EdgeInsets.all(8.0), child: Column(children: [
            const ComponentStatusStatusFieldHeader(name: 'List Meta'),
                            if(status.metadata?.continueState != null)
                ComponentStatusStatusField(name: 'Continue State', value: status.metadata?.continueState, color: Theme.of(context).colorScheme.surface)
,
              if(status.metadata?.remainingItemCount != null)
                ComponentStatusStatusField(name: 'Remaining Item Count', value: status.metadata?.remainingItemCount, color: Theme.of(context).colorScheme.surface)
,
              if(status.metadata?.resourceVersion != null)
                ComponentStatusStatusField(name: 'Resource Version', value: status.metadata?.resourceVersion, color: Theme.of(context).colorScheme.surface)
,
              if(status.metadata?.selfLink != null)
                ComponentStatusStatusField(name: 'Self Link', value: status.metadata?.selfLink, color: Theme.of(context).colorScheme.surface)

          ]))),

      ],
    );
  }
}

class ComponentStatusStatusFieldHeader extends StatelessWidget {
  const ComponentStatusStatusFieldHeader({super.key, required this.name, this.color});

  final String name;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Text(name, style: Theme.of(context).textTheme.titleMedium?.copyWith(color: color));
  }
}

class ComponentStatusStatusField extends StatelessWidget {
  const ComponentStatusStatusField({super.key, required this.name, required this.value, this.color, this.textColor});

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
            ComponentStatusStatusFieldHeader(name: name, color: textColor),
            valueWidget,
          ],
        ),
      ),
    );
  }
}
