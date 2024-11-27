class AzureFileVolumeSource {
  late bool readOnly;
  late String secretName;
  late String shareName;

  AzureFileVolumeSource.fromMap(Map<String, dynamic> data) {
    readOnly = data['readOnly'];
    secretName = data['secretName'];
    shareName = data['shareName'];
  }
}
