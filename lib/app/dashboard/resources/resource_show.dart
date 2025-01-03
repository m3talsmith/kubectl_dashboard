import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:humanizer/humanizer.dart';
import 'package:kubectl_dashboard/app/dashboard/resources/providers.dart';

import 'show/metatdata.dart';
import 'show/spec.dart';
import 'show/status.dart';

class ResourceShow extends ConsumerStatefulWidget {
  const ResourceShow({super.key});

  @override
  ConsumerState<ResourceShow> createState() => _ResourceShowState();
}

class _ResourceShowState extends ConsumerState<ResourceShow> {
  final List<_Page> pages = [];

  @override
  void initState() {
    super.initState();
    final resource = ref.read(currentResourceProvider);
    if (resource?.metadata != null) {
      setState(() {
        pages.add(_Page(
            title: 'Metadata',
            page: const MetadataPage(),
            icon: const Icon(Icons.info_rounded)));
      });
    }
    if (resource?.spec != null) {
      setState(() {
        pages.add(_Page(
            title: 'Spec',
            page: const SpecPage(),
            icon: const Icon(Icons.settings_applications_rounded)));
      });
    }
    if (resource?.status != null) {
      setState(() {
        pages.add(_Page(
            title: 'Status',
            page: const StatusPage(),
            icon: const Icon(Icons.access_time_rounded)));
      });
    }
  }

  int _currentPage = 0;
  @override
  Widget build(BuildContext context) {
    final resource = ref.watch(currentResourceProvider);

    return Scaffold(
      appBar: resource != null
          ? AppBar(
              centerTitle: true,
              title: Text(
                  '${resource.kind!.toTitleCase()}: ${resource.metadata!.name}'),
            )
          : null,
      body: resource != null
          ? pages[_currentPage].page
          : const Center(
              child: Column(
                children: [
                  CircularProgressIndicator(),
                ],
              ),
            ),
      bottomNavigationBar: pages.length > 1
          ? BottomNavigationBar(
              currentIndex: _currentPage,
              onTap: (index) => setState(() => _currentPage = index),
              items: pages
                  .map((page) => BottomNavigationBarItem(
                      label: page.title,
                      icon: page.icon ?? const Icon(Icons.list)))
                  .toList(),
            )
          : null,
    );
  }
}

class _Page {
  _Page({required this.title, required this.page, this.icon});

  final String title;
  final Widget page;
  Widget? icon;
}
