class SecretKeySelector {
  late String key;
  late String name;
  late bool optional;

  SecretKeySelector.fromMap(Map<String, dynamic> data) {
    key = data['key'];
    name = data['name'];
    optional = data['optional'];
  }
}
