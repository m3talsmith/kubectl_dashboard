import 'dart:io';

import 'package:humanizer/humanizer.dart';
import 'package:kuberneteslib/kuberneteslib.dart';
import 'package:yaml/yaml.dart';

void main() {
  const pathName = 'lib/app/dashboard/resources/show';
  const tilesDirectory = '$pathName/status_tiles';

  const switchCasesFilename = '$pathName/status_switch_cases.dart';
  final tiles = <String>[];
  final switchCases = <String>[];
  for (final kind in ResourceKind.values) {
    if (kind == ResourceKind.unknown) continue;
    final humanizedKind = SymbolName(kind.name).toHumanizedName();
    final parts = humanizedKind.split(' ');
    final kindSnakeCased = parts.map((e) => e.toLowerCase()).join('_');
    final kindPascalCased = parts.map((e) => e.toTitleCase()).join('');

    final propertiesFile = File('properties/status/$kindSnakeCased.yaml');
    final properties = loadYaml(propertiesFile.readAsStringSync());
    final propertiesMap = <String, Map<String, dynamic>>{};
    if (properties != null) {
      for (final property in properties.entries) {
        final key = property.key.toString();
        Map<String, dynamic> value = {};
        if (property.value == null) {
          value[SymbolName(key).toHumanizedName().toTitleCase()] = null;
        } else if (property.value is YamlMap) {
          value[SymbolName(property.value['kind'])
              .toHumanizedName()
              .toTitleCase()] = property.value['properties'];
        } else {
          value[SymbolName(key).toHumanizedName().toTitleCase()] =
              property.value.toString();
        }
        propertiesMap[key] = value;
      }
    }

    switchCases.add('''
case ${kindPascalCased}Status status:
  log('[${kindPascalCased}StatusView] status: \${status.toJson()}');
  return ${kindPascalCased}StatusView(status: status! as ${kindPascalCased}Status);
''');

    final tileContent = '''
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:kuberneteslib/kuberneteslib.dart';

class ${kindPascalCased}StatusView extends StatelessWidget {
  const ${kindPascalCased}StatusView({super.key, required this.status});

  final ${kindPascalCased}Status status;

  @override
  Widget build(BuildContext context) {
    log('[${kindPascalCased}StatusView] status: \${status.toJson()}');
    final size = MediaQuery.sizeOf(context);
    return StaggeredGrid.count(
      crossAxisCount: size.width ~/ 300,
      children: [
        ${propertiesMap.entries.map((e) {
      final key = e.key;
      final value = e.value;
      String content = '';
      for (final valueEntry in value.entries) {
        final valueKey = valueEntry.key;
        final valueValue = valueEntry.value;
        switch (valueValue) {
          case YamlMap map:
            print(map);
            content += '''
          if(status.${key} != null)
            Card(child: Padding(padding: const EdgeInsets.all(8.0), child: Column(children: [
            const ${kindPascalCased}StatusFieldHeader(name: '${valueKey}'),
              ${map.entries.map((item) => '''
              if(status.$key?.${item.key} != null)
                ${kindPascalCased}StatusField(name: '${SymbolName(item.key).toHumanizedName().toTitleCase()}', value: status.$key?.${item.key}, color: Theme.of(context).colorScheme.surface)
''').join(',\n')}
          ]))),
''';
          case YamlList list:
            content += '''
          if(status.${key} != null)
            ...?status.${key}?.map((e) => Card(child: Padding(padding: const EdgeInsets.all(8.0), child: Column(children: [
            const ${kindPascalCased}StatusFieldHeader(name: '${valueKey}'),
              ${list.map((item) => '''
              if(e.$item != null)
                ${kindPascalCased}StatusField(name: '${SymbolName(item).toHumanizedName().toTitleCase()}', value: e.$item, color: Theme.of(context).colorScheme.surface)
''').join(',\n')}
          ])))),
''';
            break;
          default:
            content += '''
          if(status.${key} != null)
            ${kindPascalCased}StatusField(name: '${valueKey}', value: status.${key}),
''';
            break;
        }
      }
      return content;
    }).join('\n\t\t\t')}
      ],
    );
  }
}

class ${kindPascalCased}StatusFieldHeader extends StatelessWidget {
  const ${kindPascalCased}StatusFieldHeader({super.key, required this.name, this.color});

  final String name;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Text(name, style: Theme.of(context).textTheme.titleMedium?.copyWith(color: color));
  }
}

class ${kindPascalCased}StatusField extends StatelessWidget {
  const ${kindPascalCased}StatusField({super.key, required this.name, required this.value, this.color, this.textColor});

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
          children: map.entries.map((e) => Text('\${e.key}: \${e.value}', style: Theme.of(context).textTheme.bodySmall?.copyWith(color: textColor))).toList(),
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
            ${kindPascalCased}StatusFieldHeader(name: name, color: textColor),
            valueWidget,
          ],
        ),
      ),
    );
  }
}
''';

    final file = File('$tilesDirectory/${kindSnakeCased}_status_view.dart');
    if (!file.existsSync()) {
      file.createSync(recursive: true);
    }
    file.writeAsStringSync(tileContent);

    tiles.add('status_tiles/${kindSnakeCased}_status_view.dart');
  }

  final switchCaseContent = '''
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:kuberneteslib/kuberneteslib.dart';

${tiles.map((e) => "import '$e';").join('\n')}

Widget buildStatus({Status? status}) {
  if (status == null) {
    log('[buildStatus] status is null');
    return const SizedBox.shrink();
  }
  switch (status.runtimeType) {
    ${switchCases.join('\n\t\t')}
  default:
    log('[buildStatus] default: \${status?.runtimeType}');
    return const SizedBox.shrink();
  }
}
''';

  File(switchCasesFilename).writeAsStringSync(switchCaseContent);
}
