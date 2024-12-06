import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kubectl_dashboard/app/auth.dart';
import 'package:kubectl_dashboard/app/dashboard/resources/providers.dart';
import 'package:kuberneteslib/kuberneteslib.dart';

class ResourceForm extends ConsumerStatefulWidget {
  const ResourceForm({super.key, this.resource, required this.kind});

  final Resource? resource;
  final String kind;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ResourceFormState();
}

class _ResourceFormState extends ConsumerState<ResourceForm> {
  String? data;

  submit(BuildContext context) async {
    var resources = ref.watch(resourcesProvider);
    final nav = Navigator.of(context);

    if (data != null && data!.isNotEmpty) {
      Resource? resource = Resource.fromYaml(data!);
      if (resource == null) return;

      final auth = ref.watch(authenticationProvider);
      resource.auth = auth;

      final newResource = await resource.save();
      if (newResource == null) return;

      var index = resources.length - 1;

      if (widget.resource != null) {
        if (resources.contains(widget.resource!)) {
          index = resources.indexOf(widget.resource!);
          resources[index] = newResource;
        }
      } else {
        resources.add(newResource);
      }

      ref.watch(currentResourceProvider.notifier).state = newResource;
      ref.watch(resourcesProvider.notifier).state = resources;
    }

    nav.pop();
  }

  @override
  void initState() {
    super.initState();
    if (widget.resource != null) {
      data = widget.resource!.toKubernetesYaml();
    } else {
      final resource = Resource()..kind = widget.kind;
      data = resource.toKubernetesYaml();
    }
  }

  @override
  Widget build(BuildContext context) {
    final undoController = UndoHistoryController();
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          Expanded(
            child: TextFormField(
              undoController: undoController,
              autofocus: true,
              initialValue: data,
              keyboardType: TextInputType.multiline,
              maxLines: null,
              expands: true,
              onChanged: (value) {
                setState(() {
                  data = value;
                });
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: ElevatedButton(
                onPressed: () async => await submit(context),
                child: Text('Save ${widget.kind}')),
          )
        ],
      ),
    );
  }
}
