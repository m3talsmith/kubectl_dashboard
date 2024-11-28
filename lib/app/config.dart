import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:kubernetes/kubernetes.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

Future<void> saveConfigs(List<Config>? state) async {
  if (state == null) return;

  final rootPath = await getApplicationSupportDirectory();
  final configsPath = join(rootPath.path, "configs.json");
  log('configsPath: $configsPath');

  final configs = Configs(configs: state);
  final json = jsonEncode(configs);
  File(configsPath).writeAsStringSync(json);
}

Future<List<Config>> loadConfigs() async {
  final rootPath = await getApplicationSupportDirectory();
  final configsPath = join(rootPath.path, "configs.json");

  try {
    final file = File(configsPath);
    final buff = file.readAsStringSync();
    final json = jsonDecode(buff);
    final configs = Configs.fromJson(json['configs']).toList();
    return configs;
  } on PathNotFoundException {
    await File(configsPath).create();
    await saveConfigs([]);
    return loadConfigs();
  } catch (exception, stackTrace) {
    log('[ERROR] loadConfigs: $exception\n$stackTrace');
    return [];
  }
}
