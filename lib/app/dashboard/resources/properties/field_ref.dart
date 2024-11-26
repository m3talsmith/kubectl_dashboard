class FieldRef {
  late String? apiVersion;
  late String? fieldPath;

  FieldRef.fromMap(Map<String, dynamic> data) {
    apiVersion = data['apiVersion'];
    fieldPath = data['fieldPath'];
  }
}
