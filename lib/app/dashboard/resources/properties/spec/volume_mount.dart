class VolumeMount {
  String? mountPath;
  String? mountPropagation;
  String? name;
  bool? readOnly;
  String? subPath;
  String? subPathExpr;

  VolumeMount.fromMap(Map<String, dynamic> data) {
    mountPath = data['mountPath'];
    mountPropagation = data['mountPropagation'];
    name = data['name'];
    readOnly = data['readOnly'];
    subPath = data['subPath'];
    subPathExpr = data['subPathExpr'];
  }
}
