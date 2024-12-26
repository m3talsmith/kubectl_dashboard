import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kubectl_dashboard/app/app_drawer.dart';
import 'package:kubectl_dashboard/app/config/providers.dart';
import 'package:kubectl_dashboard/app/dashboard.dart';
import 'package:kubectl_dashboard/app/dashboard/resources/providers.dart';
import 'package:kubectl_dashboard/app/dashboard/resources/resource_show.dart';
import 'package:kubectl_dashboard/app/preferences.dart';
import 'package:kubectl_dashboard/window.dart';
import 'package:window_manager/window_manager.dart';

import 'app/config/add_config.dart';

class App extends ConsumerStatefulWidget {
  const App({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AppState();
}

class _AppState extends ConsumerState<App> with WindowListener {
  @override
  void initState() {
    super.initState();
    windowManager.addListener(this);
  }

  @override
  void dispose() {
    windowManager.removeListener(this);
    super.dispose();
  }

  @override
  onWindowMove() async {
    super.onWindowMove();

    final fullscreen = ref.watch(fullscreenProvider);
    ref.watch(preferencesProvider.notifier).state?.fullscreen = fullscreen;

    final offset = await windowManager.getPosition();
    final preferences = ref.watch(preferencesProvider);
    final currentPosition = preferences?.windowPosition;
    final position = WindowPosition(top: offset.dx, left: offset.dy);

    if (currentPosition != null &&
        (currentPosition.top != offset.dx ||
            currentPosition.left != offset.dy)) {
      if (!fullscreen) {
        ref.watch(preferencesProvider.notifier).state?.windowPosition =
            position;
      }
    } else {
      ref.watch(preferencesProvider.notifier).state?.windowPosition = position;
    }
  }

  @override
  void onWindowResize() async {
    super.onWindowResize();

    final fullscreen = ref.watch(fullscreenProvider);
    ref.watch(preferencesProvider.notifier).state?.fullscreen = fullscreen;

    final size = await windowManager.getSize();

    if (!fullscreen) {
      ref.watch(preferencesProvider.notifier).state?.windowSize = size;
    }
  }

  @override
  Widget build(BuildContext context) {
    final config = ref.watch(currentConfigProvider);
    final currentContextIndex = ref.watch(currentContextIndexProvider);
    final resources = ref.watch(resourcesProvider);
    final searchController = SearchController();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Kubectl Dashboard',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: Builder(builder: (context) {
        final fullscreen = ref.watch(fullscreenProvider);
        final size = MediaQuery.of(context).size;

        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const Text('Kubectl Dashboard'),
            actions: [
              if (resources.isNotEmpty)
                SearchAnchor(
                  searchController: searchController,
                  builder: (context, controller) {
                    return IconButton(
                        onPressed: () {
                          controller.openView();
                        },
                        icon: const Icon(Icons.search_rounded));
                  },
                  suggestionsBuilder: (context, controller) {
                    return resources
                        .where(
                          (e) =>
                              e.metadata!.name!.contains(controller.text) ||
                              e.namespace!.contains(controller.text),
                        )
                        .map(
                          (e) => ListTile(
                            onTap: () async {
                              final nav = Navigator.of(context);
                              ref
                                  .watch(currentResourceProvider.notifier)
                                  .state = e;
                              await nav.push(MaterialPageRoute(
                                builder: (context) => const ResourceShow(),
                              ));
                              nav.pop();
                            },
                            title: Text(e.metadata!.name!),
                            subtitle: Text(e.namespace!),
                          ),
                        );
                  },
                ),
              if (!kIsWeb)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: IconButton(
                      onPressed: () {
                        windowManager.setFullScreen(!fullscreen);
                        ref.watch(fullscreenProvider.notifier).state =
                            !fullscreen;
                      },
                      icon: Icon(fullscreen
                          ? Icons.fullscreen_exit_rounded
                          : Icons.fullscreen_rounded)),
                )
            ],
          ),
          body: (config != null)
              ? DashboardView(contextIndex: currentContextIndex)
              : Center(
                  child: Card(
                    child: SizedBox(
                      height: size.height / 3,
                      width: size.width / 3,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            const Expanded(
                              child: Text(
                                  'Please select a config from the drawer or add a new one.'),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: FilledButton.icon(
                                onPressed: () async {
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => const AddConfig(),
                                  ));
                                },
                                icon: const Icon(Icons.add),
                                label: const Text('Add Cluster'),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
          drawer: const AppDrawer(),
        );
      }),
    );
  }
}
