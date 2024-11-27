class SELinuxOptions {
  String? level;
  String? role;
  String? type;
  String? user;

  SELinuxOptions.fromMap(Map<String, dynamic> data) {
    level = data['level'];
    role = data['role'];
    type = data['type'];
    user = data['user'];
  }
}
