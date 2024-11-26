import 'condition.dart';
import 'container_status.dart';

class Status {
  // pods
  String? phase;
  late List<Condition> conditions;
  String? hostIP;
  late List<Map<String, String>> hostIPs;
  String? podIP;
  late List<Map<String, String>> podIPs;
  DateTime? startTime;
  late List<ContainerStatus> containerStatuses;
  String? qosClass;

  // deployments
  int? observedGeneration;
  int? replicas;
  int? updatedReplicas;
  int? readyReplicas;
  int? availableReplicas;

  Status.fromMap(Map<String, dynamic> data) {
    phase = data['phase'];

    conditions = [];
    if (data.containsKey('conditions')) {
      for (Map<String, dynamic> e in data['conditions']) {
        conditions.add(Condition.fromMap(e));
      }
    }

    hostIP = data['hostIP'];
    hostIPs = [];
    if (data.containsKey('hostIPs')) {
      for (Map<String, dynamic> e in (data['hostIPs'] as List<dynamic>)) {
        final Map<String, String> h = {};
        e.forEach((key, value) => h[key] = value);
        hostIPs.add(h);
      }
    }

    podIP = data['podIP'];
    podIPs = [];
    if (data.containsKey('podIPs')) {
      for (Map<String, dynamic> e in (data['podIPs'] as List<dynamic>)) {
        final Map<String, String> p = {};
        e.forEach((key, value) => p[key] = value);
        podIPs.add(p);
      }
    }

    if (data.containsKey('startTime')) {
      startTime = DateTime.parse(data['startTime']);
    }

    containerStatuses = [];
    if (data.containsKey('containerStatuses')) {
      for (Map<String, dynamic> e in data['containerStatuses']) {
        containerStatuses.add(ContainerStatus.fromMap(e));
      }
    }

    qosClass = data['qosClass'];

    observedGeneration = data['observedGeneration'];
    replicas = data['replicas'];
    updatedReplicas = data['updatedReplicas'];
    readyReplicas = data['readyReplicas'];
    availableReplicas = data['availableReplicas'];
  }
}
