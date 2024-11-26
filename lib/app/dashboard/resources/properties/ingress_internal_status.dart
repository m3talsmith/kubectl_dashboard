import 'internal_status.dart';

class IngressInternalStatus implements InternalStatus {
  late String ip;
  late String ipMode;

  IngressInternalStatus.fromMap(Map<String, dynamic> data) {
    ip = data['ip'];
    ipMode = data['ipMode'];
  }
}
