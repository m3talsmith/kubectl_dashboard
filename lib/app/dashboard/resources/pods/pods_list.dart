import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kubectl_dashboard/app/dashboard/resources/pods/providers.dart';

class PodsList extends ConsumerWidget {
  const PodsList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pods = ref.watch(podsProvider);
    return GridView.count(
      crossAxisCount: 3,
      children: pods
          .map(
            (e) => SizedBox(
              width: 120,
              height: 120,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Text(e.name??'unknown')
                    ],
                  ),
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}
