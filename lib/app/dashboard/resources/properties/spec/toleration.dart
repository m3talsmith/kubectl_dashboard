class Toleration {
  String? effect;
  String? key;
  String? operator;
  int? tolerationSeconds;
  String? value;

  Toleration.fromMap(Map<String, dynamic> data) {
    effect = data['effect'];
    key = data['key'];
    operator = data['operator'];
    tolerationSeconds = data['tolerationSeconds'];
    value = data['value'];
  }
}
