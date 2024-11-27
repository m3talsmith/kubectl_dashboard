class PodOS {
  late String name;

  PodOS.fromMap(Map<String, dynamic> data) {
    name = data['name'];
  }
}
