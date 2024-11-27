class PodDNSConfigOption {
  late String name;
  String? value;

  PodDNSConfigOption.fromMap(Map<String, dynamic> data) {
    name = data['name'];
    value = data['value'];
  }
}
