class GCEPersistentDiskVolumeSource {
  late String fsType;
  late int partition;
  late String pdName;
  late bool readOnly;

  GCEPersistentDiskVolumeSource.fromMap(Map<String, dynamic> data) {
    fsType = data['fsType'];
    partition = data['partition'];
    pdName = data['pdName'];
    readOnly = data['readOnly'];
  }
}
