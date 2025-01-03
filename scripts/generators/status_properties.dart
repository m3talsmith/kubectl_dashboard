import 'dart:io';

import 'package:humanizer/humanizer.dart';
import 'package:kuberneteslib/kuberneteslib.dart';

void main() {
  const pathName = 'properties/status';
  for (final kind in ResourceKind.values) {
    final humanizedKind = SymbolName(kind.name).toHumanizedName();
    final parts = humanizedKind.split(' ');
    final kindSnakeCased = parts.map((e) => e.toLowerCase()).join('_');
    final filename = '$pathName/$kindSnakeCased.yaml';
    final content = '';
    final file = File(filename);
    if (file.existsSync()) {
      continue;
    }
    file.writeAsStringSync(content);
  }
}
