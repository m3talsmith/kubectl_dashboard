class SeccompProfile {
  late String localhostProfile;
  late String type;

  SeccompProfile.fromMap(Map<String, dynamic> data) {
    localhostProfile = data['localhostProfile'];
    type = data['type'];
  }
}
