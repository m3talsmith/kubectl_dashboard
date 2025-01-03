import 'dart:io';

import 'package:humanizer/humanizer.dart';
import 'package:kuberneteslib/kuberneteslib.dart';

void main() {
  final switchCases = <String>[];
  final kinds = ResourceKind.values.map((e) => e.name).toList();
  for (final kind in kinds) {
    if (kind == 'unknown') continue;
    final humanizedKind = SymbolName(kind).toHumanizedName();
    final parts = humanizedKind.split(' ');
    final kindPascalCased = parts.map((e) => e.toTitleCase()).join('');
    switchCases.add('''
      case ResourceKind.$kind:
        return ${kindPascalCased}Status.fromJson(status.toJson());
''');
  }

  final pathName = 'lib/app/dashboard/resources/show';
  final filename = '$pathName/status_helper.dart';
  final content = '''
// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:kuberneteslib/kuberneteslib.dart';

class StatusHelper {
  static Status? fromKind(ResourceKind kind, Status? status) {
    if (status == null) {
      return null;
    }
    switch (kind) {
      ${switchCases.join('\n')}
      default:
        return null;
    }
  }
}
''';
  File(filename).writeAsStringSync(content);
}
