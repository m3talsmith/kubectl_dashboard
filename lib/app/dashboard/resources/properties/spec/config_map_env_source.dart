class ConfigMapEnvSource {
  late String name;
  late bool optional;

  ConfigMapEnvSource.fromMap(Map<String, dynamic> data) {
    name = data['name'];
    optional = data['optional'];
  }
}
