class Sysctl {
  late String name;
  late String value;

  Sysctl.fromMap(Map<String, dynamic> data) {
    name = data['name'];
    value = data['value'];
  }
}
