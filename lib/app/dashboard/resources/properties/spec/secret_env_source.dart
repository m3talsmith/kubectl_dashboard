class SecretEnvSource {
  late String name;
  late bool optional;

  SecretEnvSource.fromMap(Map<String, dynamic> data) {
    name = data['name'];
    optional = data['optional'];
  }
}
