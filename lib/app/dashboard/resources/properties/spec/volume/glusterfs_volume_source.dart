class GlusterfsVolumeSource {
  late String endpoint;
  late String path;
  late bool readOnly;

  GlusterfsVolumeSource.fromMap(Map<String, dynamic> data) {
    endpoint = data['endpoint'];
    path = data['path'];
    readOnly = data['readOnly'];
  }
}
