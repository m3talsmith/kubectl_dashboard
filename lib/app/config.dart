import 'package:kubeconfig/kubeconfig.dart';
import 'package:yaml/yaml.dart';

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

class Config {
  String? apiVersion;
  List<Cluster> clusters = [];
  List<Context> contexts = [];
  String? currentContext;
  String? kind;
  Map<String, dynamic> preferences = {};
  List<User> users = [];

  static Config? fromYaml(String data) {
    Config config = Config();
    var buff = loadYaml(data);
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

  Map<String, dynamic> asMap() => {
        "apiVersion": apiVersion,
        "clusters": clusters.map(
          (e) => e.asMap(),
        ),
        "contexts": contexts.map(
          (e) => e.asMap(),
        ),
        "current-context":
            (currentContext != null && currentContext!.isNotEmpty)
                ? currentContext
                : contexts.first.name,
        "kind": kind,
        "preferences": preferences,
        "users": users.map(
          (e) => e.asMap(),
        ),
      };

  YamlMap asYaml() => YamlMap.wrap(asMap());

  String toYaml() => asYaml().toString();
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

  YamlMap asYaml() => YamlMap.wrap(asMap());

  String toYaml() => asYaml().toString();
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

  YamlMap asYaml() => YamlMap.wrap(asMap());

  String toYaml() => asYaml().toString();
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

  YamlMap asYaml() => YamlMap.wrap(asMap());

  String toYaml() => asYaml().toString();
}

class Preference {
  Preference();

  Map<String, dynamic> asMap() => {};

  YamlMap asYaml() => YamlMap.wrap(asMap());

  String toYaml() => asYaml().toString();
}
