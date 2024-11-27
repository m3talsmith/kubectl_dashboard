class AzureDiskVolumeSource {
  late String cachingMode;
  late String diskName;
  late String diskURI;
  late String fsType;
  late String kind;
  late bool readOnly;

  AzureDiskVolumeSource.fromMap(Map<String, dynamic> data) {
    cachingMode = data['cachingMode'];
    diskName = data['diskName'];
    diskURI = data['diskURI'];
    fsType = data['fsType'];
    kind = data['kind'];
    readOnly = data['readOnly'];
  }
}
