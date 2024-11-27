class NodeSelectorRequirement {
  late String key;
  late String operator;
  late List<String> values;

  NodeSelectorRequirement.fromMap(Map<String, dynamic> data) {
    key = data['key'];
    operator = data['operator'];
    values = data['values'];
  }
}
