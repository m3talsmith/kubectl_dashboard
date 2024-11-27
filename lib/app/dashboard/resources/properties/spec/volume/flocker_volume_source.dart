class FlockerVolumeSource {
  late String datasetName;
  late String datasetUUID;

  FlockerVolumeSource.fromMap(Map<String, dynamic> data) {
    datasetName = data['datasetName'];
    datasetUUID = data['datasetUUID'];
  }
}
