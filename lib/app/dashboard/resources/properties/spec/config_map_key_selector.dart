class ConfigMapKeySelector {
  late String key;
  late String name;
  late bool optional;

  ConfigMapKeySelector.fromMap(Map<String, dynamic> data) {
    key = data['key'];
    name = data['name'];
    optional = data['optional'];
  }
}
