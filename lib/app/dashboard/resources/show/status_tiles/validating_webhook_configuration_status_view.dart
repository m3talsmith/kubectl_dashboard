import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:kuberneteslib/kuberneteslib.dart';

class ValidatingWebhookConfigurationStatusView extends StatelessWidget {
  const ValidatingWebhookConfigurationStatusView({super.key, required this.status});

  final ValidatingWebhookConfigurationStatus status;

  @override
  Widget build(BuildContext context) {
    log('[ValidatingWebhookConfigurationStatusView] status: ${status.toJson()}');
    final size = MediaQuery.sizeOf(context);
    return StaggeredGrid.count(
      crossAxisCount: size.width ~/ 300,
      children: [
        
      ],
    );
  }
}

class ValidatingWebhookConfigurationStatusFieldHeader extends StatelessWidget {
  const ValidatingWebhookConfigurationStatusFieldHeader({super.key, required this.name, this.color});

  final String name;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Text(name, style: Theme.of(context).textTheme.titleMedium?.copyWith(color: color));
  }
}

class ValidatingWebhookConfigurationStatusField extends StatelessWidget {
  const ValidatingWebhookConfigurationStatusField({super.key, required this.name, required this.value, this.color, this.textColor});

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
            ValidatingWebhookConfigurationStatusFieldHeader(name: name, color: textColor),
            valueWidget,
          ],
        ),
      ),
    );
  }
}
