import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kubectl_dashboard/app/config.dart';
import 'package:kubectl_dashboard/app/dashboard/dashboard_list_tile.dart';

class DashboardView extends ConsumerStatefulWidget {
  const DashboardView({required this.config, super.key});

  final Config config;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DashboardViewState();

}

class _DashboardViewState extends ConsumerState<DashboardView> {

  int _index = 0;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Row(
      children: [
        Container(
          // color: Theme.of(context).primaryColor,
          height: size.height,
          width: 200,
          child: ListView(
            shrinkWrap: true,
            children: [
              DashboardListTile(
                title: Text('Pods'),
                selected: _index == 0,
                onTap: () {
                  setState(() {
                    _index = 0;
                  });
                },
              ),
              DashboardListTile(
                title: Text('Deployments'),
                selected: _index == 1,
                onTap: () {
                  setState(() {
                    _index = 1;
                  });
                },
              ),
              DashboardListTile(
                title: Text('Ingress'),
                selected: _index == 2,
                onTap: () {
                  setState(() {
                    _index = 2;
                  });
                },
              ),
              DashboardListTile(
                title: Text('Certificates'),
                selected: _index == 3,
                onTap: () {
                  setState(() {
                    _index = 3;
                  });
                },
              ),
            ],
          ),
        ),
        Container(
          height: size.height,
          width: size.width-200,
          child: ListView(
            shrinkWrap: true,
            children: [],
          ),
        ),
      ],
    );
  }

}