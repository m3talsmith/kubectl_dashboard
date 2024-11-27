class SecretKeySelector {
  String? key;
  String? name;
  bool? optional;

  SecretKeySelector.fromMap(Map<String, dynamic> data) {
    key = data['key'];
    name = data['name'];
    optional = data['optional'];
  }
}
