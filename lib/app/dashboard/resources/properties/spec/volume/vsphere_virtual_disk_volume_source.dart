class VsphereVirtualDiskVolumeSource {
  late String fsType;
  late String storagePolicyID;
  late String storagePolicyName;
  late String volumePath;

  VsphereVirtualDiskVolumeSource.fromMap(Map<String, dynamic> data) {
    fsType = data['fsType'];
    storagePolicyID = data['storagePolicyID'];
    storagePolicyName = data['storagePolicyName'];
    volumePath = data['volumePath'];
  }
}
