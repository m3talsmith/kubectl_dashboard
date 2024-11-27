class NFSVolumeSource {
  late String path;
  late bool readOnly;
  late String server;

  NFSVolumeSource.fromMap(Map<String, dynamic> data) {
    path = data['path'];
    readOnly = data['readOnly'];
    server = data['server'];
  }
}
