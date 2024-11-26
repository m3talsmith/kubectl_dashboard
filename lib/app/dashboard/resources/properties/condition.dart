class Condition {
  // pods
  late String type;
  late String status;
  DateTime? lastProbeTime;
  DateTime? lastTransitionTime;

  // deployments
  DateTime? lastUpdateTime;
  String? reason;
  String? message;

  Condition.fromMap(Map<String, dynamic> data) {
    type = data['type'];
    status = data['status'];
    if (data.containsKey('lastProbeTime') && data['lastProbeTime'] != null) {
      lastProbeTime = DateTime.parse(data['lastProbeTime']);
    }
    if (data.containsKey('lastTransitionTime') &&
        data['lastTransitionTime'] != null) {
      lastTransitionTime = DateTime.tryParse(data['lastTransitionTime']);
    }
    if (data.containsKey('lastUpdateTime') && data['lastUpdateTime'] != null) {
      lastUpdateTime = DateTime.tryParse(data['lastUpdateTime']);
    }
    reason = data['reason'];
    message = data['message'];
  }
}
