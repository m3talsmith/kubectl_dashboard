class SeccompProfile {
  String? localhostProfile;
  String? type;

  SeccompProfile.fromMap(Map<String, dynamic> data) {
    localhostProfile = data['localhostProfile'];
    type = data['type'];
  }
}
