import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../providers.dart';

class SpecPage extends ConsumerWidget {
  const SpecPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final resource = ref.watch(currentResourceProvider);
    final spec = resource?.spec;
    if (spec == null) return const SizedBox.shrink();
    final size = MediaQuery.sizeOf(context);

    return StaggeredGrid.count(
      crossAxisCount: size.width ~/ 300,
      children: [],
    );
  }
}

class _SpecFieldHeader extends StatelessWidget {
  const _SpecFieldHeader({required this.name});

  final String name;

  @override
  Widget build(BuildContext context) {
    return Text(name, style: Theme.of(context).textTheme.bodyLarge);
  }
}

class _SpecField extends StatelessWidget {
  const _SpecField({required this.name, required this.value});

  final String name;
  final dynamic value;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(children: [
          _SpecFieldHeader(name: name),
          Text(value.toString()),
        ]),
      ),
    );
  }
}
