class AWSElasticBlockStoreVolumeSource {
  late String fsType;
  late int partition;
  late bool readOnly;
  late String volumeID;

  AWSElasticBlockStoreVolumeSource.fromMap(Map<String, dynamic> data) {
    fsType = data['fsType'];
    partition = data['partition'];
    readOnly = data['readOnly'];
    volumeID = data['volumeID'];
  }
}
