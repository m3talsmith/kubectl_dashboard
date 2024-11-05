import 'package:flutter/material.dart';

import '../config.dart';

class ConfigListTile extends StatelessWidget {
  const ConfigListTile({required this.config, this.selected, this.onTap, super.key});

  final Config config;
  final Config? selected;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    if (selected != null && config == selected!) {
      return Padding(
        padding: const EdgeInsets.only(right: 8.0),
        child: ListTile(
          onTap: onTap,
          title: Text(config.currentContext ?? 'unknown'),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(16),
              bottomRight: Radius.circular(16),
            ),
          ),
          tileColor: Colors.deepPurple,
          textColor: Colors.white,
          trailing: const Icon(Icons.star_rounded, color: Colors.white,),
        ),
      );
    }
    return ListTile(
      onTap: onTap,
      title: Text(config.currentContext ?? 'unknown'),
    );
  }
}