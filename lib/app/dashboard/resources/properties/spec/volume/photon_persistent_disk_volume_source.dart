class PhotonPersistentDiskVolumeSource {
  late String fsType;
  late String pdID;

  PhotonPersistentDiskVolumeSource.fromMap(Map<String, dynamic> data) {
    fsType = data['fsType'];
    pdID = data['pdID'];
  }
}
