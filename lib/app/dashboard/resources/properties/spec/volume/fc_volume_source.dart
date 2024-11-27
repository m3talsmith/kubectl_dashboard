class FCVolumeSource {
  late String fsType;
  late int lun;
  late bool readOnly;
  late List<String> targetWWNs;
  late List<String> wwids;

  FCVolumeSource.fromMap(Map<String, dynamic> data) {
    fsType = data['fsType'];
    lun = data['lun'];
    readOnly = data['readOnly'];
    targetWWNs = data['targetWWNs'] as List<String>;
    wwids = data['wwids'] as List<String>;
  }
}
