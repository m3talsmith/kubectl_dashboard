class LocalObjectReference {
  late String name;

  LocalObjectReference.fromMap(Map<String, dynamic> data) {
    name = data['name'];
  }
}
