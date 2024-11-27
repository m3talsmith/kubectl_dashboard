class HostPathVolumeSource {
  late String path;
  late String type;

  HostPathVolumeSource.fromMap(Map<String, dynamic> data) {
    path = data['path'];
    type = data['type'];
  }
}
