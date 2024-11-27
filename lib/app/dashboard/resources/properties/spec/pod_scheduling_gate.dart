class PodSchedulingGate {
  late String name;

  PodSchedulingGate.fromMap(Map<String, dynamic> data) {
    name = data['name'];
  }
}
