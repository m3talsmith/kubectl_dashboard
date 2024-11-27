class ObjectFieldSelector {
  late String apiVersion;
  late String fieldPath;

  ObjectFieldSelector.fromMap(Map<String, dynamic> data) {
    apiVersion = data['apiVersion'];
    fieldPath = data['fieldPath'];
  }
}
