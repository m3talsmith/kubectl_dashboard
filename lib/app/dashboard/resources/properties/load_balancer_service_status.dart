import 'ingress_internal_status.dart';
import 'internal_status.dart';
import 'service_status.dart';

class LoadBalancerStatus implements ServiceStatus {
  late Map<String, InternalStatus> statuses;

  LoadBalancerStatus.fromMap(Map<String, dynamic> data) {
    for (var e in data.entries) {
      switch (e.key) {
        case 'ingress':
          statuses[e.key] = IngressInternalStatus.fromMap(e.value);
      }
    }
  }
}
