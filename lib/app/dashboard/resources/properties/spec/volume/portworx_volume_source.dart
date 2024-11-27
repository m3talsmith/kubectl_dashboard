class PortworxVolumeSource {
  late String fsType;
  late bool readOnly;
  late String volumeID;

  PortworxVolumeSource.fromMap(Map<String, dynamic> data) {
    fsType = data['fsType'];
    readOnly = data['readOnly'];
    volumeID = data['volumeID'];
  }
}
