class Toleration {
  late String? key;
  late String? operator;
  late String? effect;
  late int? tolerationSeconds;

  Toleration.fromMap(Map<String, dynamic> data) {
    key = data['key'];
    operator = data['operator'];
    effect = data['effect'];
    tolerationSeconds = data['tolerationSeconds'];
  }
}
