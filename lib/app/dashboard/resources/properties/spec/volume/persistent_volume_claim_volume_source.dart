class PersistentVolumeClaimVolumeSource {
  late String claimName;
  late bool readOnly;

  PersistentVolumeClaimVolumeSource.fromMap(Map<String, dynamic> data) {
    claimName = data['claimName'];
    readOnly = data['readOnly'];
  }
}
