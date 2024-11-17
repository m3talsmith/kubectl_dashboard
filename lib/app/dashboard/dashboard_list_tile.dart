import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DashboardListTile extends ConsumerWidget {
  const DashboardListTile({
    this.title,
    this.selected = false,
    this.shape,
    this.onTap,
    super.key,
  });

  final Widget? title;
  final bool selected;
  final ShapeBorder? shape;
  final Function()? onTap;

  tapSelected() {
    Future.delayed(
      const Duration(milliseconds: 300),
      () {
        if (selected && onTap != null) onTap!();
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    tapSelected();
    return ListTile(
      selectedColor: Theme.of(context).canvasColor,
      selectedTileColor: Theme.of(context).primaryColor,
      iconColor: Theme.of(context).canvasColor,
      selected: selected,
      shape: (shape != null)
          ? shape
          : const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),
            ),
      onTap: onTap,
      title: title,
      trailing: selected ? const Icon(Icons.star_rounded) : null,
    );
  }
}
