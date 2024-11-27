class TypedLocalObjectReference {
  late String apiGroup;
  late String kind;
  late String name;

  TypedLocalObjectReference.fromMap(Map<String, dynamic> data) {
    apiGroup = data['apiGroup'];
    kind = data['kind'];
    name = data['name'];
  }
}
