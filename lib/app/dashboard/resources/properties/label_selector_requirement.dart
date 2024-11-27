class LabelSelectorRequirement {
  late String key;
  late String operator;
  late List<String> values;

  LabelSelectorRequirement.fromMap(Map<String, dynamic> data) {
    key = data['key'];
    operator = data['operator'];
    values = data['values'] as List<String>;
  }
}
