class VolumeMount {
  late String? name;
  late bool? readOnly;
  late String? mountPath;

  VolumeMount.fromMap(Map<String, dynamic> data) {
    name = data['name'];
    readOnly = data['readOnly'];
    mountPath = data['mountPath'];
  }
}
