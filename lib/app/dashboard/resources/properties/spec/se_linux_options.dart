class SELinuxOptions {
  late String level;
  late String role;
  late String type;
  late String user;

  SELinuxOptions.fromMap(Map<String, dynamic> data) {
    level = data['level'];
    role = data['role'];
    type = data['type'];
    user = data['user'];
  }
}
