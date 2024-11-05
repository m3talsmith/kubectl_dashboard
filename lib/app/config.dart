import 'dart:convert';
import 'dart:io';

import 'package:kubeconfig/kubeconfig.dart';
import 'package:yaml/yaml.dart';
import 'package:yaml_writer/yaml_writer.dart';
import 'package:yaml/yaml.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

dynamic _convertNode(dynamic v) {
  if (v is YamlMap) {
    return _fromYamlMap(v);
  }
  else if (v is YamlList) {
    var list = <dynamic>[];
    for (var e in v) { list.add(_convertNode(e)); }
    return list;
  }
  else {
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

saveConfigs(List<Config>? state) async {
  if (state == null) return;

  final rootPath = await getApplicationSupportDirectory();
  final configsPath = join(rootPath.path, "configs.yaml");

  final configs = Configs(configs: state);
  final yaml = YamlWriter().write(configs);
  var _ = File(configsPath).writeAsStringSync(yaml);
}

Future<List<Config>?> loadConfigs() async {
  try {
    final rootPath = await getApplicationSupportDirectory();
    final configsPath = join(rootPath.path, "configs.yaml");
    final buff = File(configsPath).readAsStringSync();
    final configs = Configs.fromYaml(buff).toList();
    return configs.isNotEmpty ? configs : null;
  } catch (_) {
    return null;
  }

}

class Configs {
  Configs({List<Config> configs=const []}) : _configs = configs;

  final List<Config> _configs;

  Configs.fromYaml(String data) : _configs = [] {
    final buff = loadYaml(data);
    for (YamlMap yamlMap in buff['configs']) {
      final config = Config.fromMap(yamlMap.cast());
      if (config != null) _configs.add(config);
    }
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
        name: u['name'],
      );
      config.users.add(user);
    }
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
        "clusters": clusters.map(
          (e) => e.asMap(),
        ).toList(),
        "contexts": contexts.map(
          (e) => e.asMap(),
        ).toList(),
        "current-context":
            (currentContext != null && currentContext!.isNotEmpty)
                ? currentContext
                : contexts.first.name,
        "kind": kind,
        "preferences": preferences,
        "users": users.map(
          (e) => e.asMap(),
        ).toList(),
      };
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
  User({this.name, this.clientCertificateData, this.clientKeyData});

  String? name;
  String? clientCertificateData;
  String? clientKeyData;

  Map<String, dynamic> asMap() => {
        "user": {
          "client-certificate-data": clientCertificateData,
          "client-key-data": clientKeyData,
        },
        "name": name,
      };
}

class Preference {
  Preference();

  Map<String, dynamic> asMap() => {};
}
