import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:kuberneteslib/kuberneteslib.dart';
import 'package:localstorage/localstorage.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

Future<void> saveConfigs(List<Config>? state) async {
  if (state == null) return;

  if (kIsWeb) {
    localStorage.setItem(
        'configs', jsonEncode(Configs(configs: state).toJson()));
    return;
  }

  final rootPath = await getApplicationSupportDirectory();
  final configsPath = join(rootPath.path, "configs.json");

  final configs = Configs(configs: state);
  final json = configs.toJson();
  File(configsPath).writeAsStringSync(jsonEncode(json));
  return;
}

Future<List<Config>> loadConfigs() async {
  if (kIsWeb) {
    final data = localStorage.getItem('configs');
    final dataMapped = jsonDecode(data ?? '{"configs":[]}');
    final configs =
        Configs.fromJson(dataMapped as Map<String, dynamic>).toList();
    return configs;
  }

  final rootPath = await getApplicationSupportDirectory();
  final configsPath = join(rootPath.path, "configs.json");

  try {
    final file = File(configsPath);
    final buff = file.readAsStringSync();
    final json = jsonDecode(buff);
    final configs = Configs.fromJson(json);
    return configs.toList();
  } on PathNotFoundException {
    await File(configsPath).create();
    await saveConfigs([]);
    return loadConfigs();
  } catch (_) {
    return [];
  }
}
