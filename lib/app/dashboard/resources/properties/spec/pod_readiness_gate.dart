class PodReadinessGate {
  late String conditionType;

  PodReadinessGate.fromMap(Map<String, dynamic> data) {
    conditionType = data['conditionType'];
  }
}
