class Toleration {
  late String effect;
  late String key;
  late String operator;
  late int tolerationSeconds;
  late String value;

  Toleration.fromMap(Map<String, dynamic> data) {
    effect = data['effect'];
    key = data['key'];
    operator = data['operator'];
    tolerationSeconds = data['tolerationSeconds'];
    value = data['value'];
  }
}
