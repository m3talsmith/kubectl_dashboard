import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:json2yaml/json2yaml.dart';
import 'package:kubeconfig/kubeconfig.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:yaml/yaml.dart';

dynamic _convertNode(dynamic v) {
  if (v is YamlMap) {
    return _fromYamlMap(v);
  } else if (v is YamlList) {
    var list = <dynamic>[];
    for (var e in v) {
      list.add(_convertNode(e));
    }
    return list;
  } else {
    return v;
  }
}

Map<String, dynamic> _fromYamlMap(YamlMap nodes) {
  var map = <String, dynamic>{};
  nodes.forEach((k, v) {
    map[k] = _convertNode(v);
  });
  return map;
}

bool valid(String data) {
  if (data.isNotEmpty) {
    try {
      var config = Kubeconfig.fromYaml(data);
      var valid = config.validate();
      return valid.code == ValidationCode.valid;
    } catch (_) {
      return false;
    }
  }
  return false;
}

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

class Configs {
  Configs({List<Config> configs = const []}) : _configs = configs;

  final List<Config> _configs;

  static Configs fromJson(List<dynamic> data) {
    final List<Config> configs = [];
    for (var c in data) {
      final config = Config.fromMap(c);
      if (config != null) configs.add(config);
    }
    return Configs(configs: configs);
  }

  Map<String, dynamic> toJson() {
    final dataMaps = [];
    for (var config in _configs) {
      dataMaps.add(config.asMap());
    }
    return {'configs': dataMaps};
  }

  List<Config> toList() {
    return _configs;
  }
}

class Config {
  String? apiVersion;
  List<Cluster> clusters = [];
  List<Context> contexts = [];
  String? currentContext;
  String? kind;
  Map<String, dynamic> preferences = {};
  List<User> users = [];
  String? displayName;

  static Config? fromMap(Map<String, dynamic> buff) {
    if (buff.isEmpty) return null;

    final config = Config();
    config.apiVersion = buff['apiVersion'] ?? '';
    for (var c in buff['clusters']) {
      Cluster cluster = Cluster(
        certificateAuthorityData: c['cluster']['certificate-authority-data'],
        server: c['cluster']['server'],
        name: c['name'],
      );
      config.clusters.add(cluster);
    }
    for (var c in buff['contexts']) {
      Context context = Context(
        cluster: c['context']['cluster'],
        user: c['context']['user'],
        name: c['name'],
      );
      config.contexts.add(context);
    }
    config.currentContext = buff['current-context'];
    config.kind = buff['kind'];
    for (var u in buff['users']) {
      User user = User(
        clientCertificateData: u['user']['client-certificate-data'],
        clientKeyData: u['user']['client-key-data'],
        exec: Exec.fromMap(u['user']['exec']),
        name: u['name'],
      );
      config.users.add(user);
    }
    config.displayName = buff['display-name'];
    return config;
  }

  static Config? fromYaml(String data) {
    if (data.isEmpty) return null;
    if (!valid(data)) return null;
    final configMapping = _fromYamlMap(loadYaml(data));
    return Config.fromMap(configMapping);
  }

  Map<String, dynamic> asMap() => {
        "apiVersion": apiVersion,
        "clusters": clusters
            .map(
              (e) => e.asMap(),
            )
            .toList(),
        "contexts": contexts
            .map(
              (e) => e.asMap(),
            )
            .toList(),
        "current-context":
            (currentContext != null && currentContext!.isNotEmpty)
                ? currentContext
                : contexts.first.name,
        "kind": kind,
        "preferences": preferences,
        "users": users
            .map(
              (e) => e.asMap(),
            )
            .toList(),
        "display-name": displayName,
      };

  String toYaml() {
    return json2yaml(asMap());
  }
}

class Cluster {
  Cluster({this.certificateAuthorityData, this.server, this.name});

  String? certificateAuthorityData;
  String? server;
  String? name;

  Map<String, dynamic> asMap() => {
        "cluster": {
          "certificate-authority-data": certificateAuthorityData,
          "server": server
        },
        "name": name,
      };
}

class Context {
  Context({this.cluster, this.user, this.name});

  String? cluster;
  String? user;
  String? name;

  Map<String, dynamic> asMap() => {
        "context": {
          "cluster": cluster,
          "user": user,
        },
        "name": name,
      };
}

class User {
  User({this.name, this.clientCertificateData, this.clientKeyData, this.exec});

  final String? name;
  final String? clientCertificateData;
  final String? clientKeyData;
  final Exec? exec;

  Map<String, dynamic> asMap() => {
        "user": {
          "client-certificate-data": clientCertificateData,
          "client-key-data": clientKeyData,
          "exec": exec?.asMap(),
        },
        "name": name,
      };
}

class Exec {
  Exec({
    this.command = 'doctl',
    this.arguments,
    this.apiVersion = 'client.authentication.k8s.io/v1beta1',
    this.env,
    this.interactiveMode = 'IfAvailable',
    this.provideClusterInfo = false,
  });

  String? command;
  List<String>? arguments;
  String? apiVersion;
  String? env;
  String? interactiveMode;
  bool? provideClusterInfo;

  Exec.fromMap(Map<String, dynamic> data) {
    command = data['command'] ?? 'doctl';

    arguments = [];
    for (var arg in data['args']) {
      arguments!.add(arg);
    }

    apiVersion = data['apiVersion'] ?? 'client.authentication.k8s.io/v1beta1';
    env = data['env'];
    interactiveMode = data['interactiveMode'] ?? 'IfAvailable';
    provideClusterInfo = data['provideClusterInfo'] ?? false;
  }

  Map<String, dynamic> asMap() => {
        "apiVersion": apiVersion,
        "args": arguments,
        "command": command,
        "env": env,
        "interactiveMode": interactiveMode,
        "provideClusterInfo": provideClusterInfo,
      };
}

class ExecResult {
  ExecResult({
    required this.kind,
    required this.apiVersion,
    required this.spec,
    required this.status,
  });

  late final String kind;
  late final String apiVersion;
  late final ExecSpec spec;
  late final ExecStatus status;

  ExecResult.fromMap(Map<String, dynamic> data) {
    kind = data['kind'];
    apiVersion = data['apiVersion'];
    spec = ExecSpec.fromMap(data['spec']);
    status = ExecStatus.fromMap(data['status']);
  }
}

class ExecSpec {
  ExecSpec({
    this.interactive = false,
  });

  late final bool interactive;

  ExecSpec.fromMap(Map<String, dynamic> data) {
    interactive = data['interactive'];
  }
}

class ExecStatus {
  ExecStatus({
    this.expirationTimestamp,
    this.token,
  });

  late final DateTime? expirationTimestamp;
  late final String? token;

  ExecStatus.fromMap(Map<String, dynamic> data) {
    expirationTimestamp = DateTime.tryParse(data['expirationTimestamp']);
    token = data['token'];
  }
}

class Preference {
  Preference();

  Map<String, dynamic> asMap() => {};
}
