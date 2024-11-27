class VolumeMount {
  late String mountPath;
  late String mountPropagation;
  late String name;
  late bool readOnly;
  late String subPath;
  late String subPathExpr;

  VolumeMount.fromMap(Map<String, dynamic> data) {
    mountPath = data['mountPath'];
    mountPropagation = data['mountPropagation'];
    name = data['name'];
    readOnly = data['readOnly'];
    subPath = data['subPath'];
    subPathExpr = data['subPathExpr'];
  }
}
