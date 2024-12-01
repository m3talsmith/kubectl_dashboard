import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DashboardListTile extends ConsumerStatefulWidget {
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

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _DashboardListTileState();
}

class _DashboardListTileState extends ConsumerState<DashboardListTile> {
  bool tapped = false;

  tapSelected() {
    Future.delayed(
      const Duration(milliseconds: 300),
      () {
        if (widget.selected && widget.onTap != null && !tapped) {
          widget.onTap!();
          setState(() {
            tapped = true;
          });
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    tapSelected();
    return ListTile(
      selectedColor: Theme.of(context).canvasColor,
      selectedTileColor: Theme.of(context).primaryColor,
      iconColor: Theme.of(context).canvasColor,
      selected: widget.selected,
      shape: (widget.shape != null)
          ? widget.shape
          : const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),
            ),
      onTap: widget.onTap,
      title: widget.title,
      trailing: widget.selected ? const Icon(Icons.star_rounded) : null,
    );
  }
}
