class TypedObjectReference {
  late String apiGroup;
  late String kind;
  late String name;
  late String namespace;

  TypedObjectReference.fromMap(Map<String, dynamic> data) {
    apiGroup = data['apiGroup'];
    kind = data['kind'];
    name = data['name'];
    namespace = data['namespace'];
  }
}
