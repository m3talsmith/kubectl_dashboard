class PersistentVolumeClaimVolumeSource {
  String? claimName;
  bool? readOnly;

  PersistentVolumeClaimVolumeSource.fromMap(Map<String, dynamic> data) {
    claimName = data['claimName'];
    readOnly = data['readOnly'];
  }
}
