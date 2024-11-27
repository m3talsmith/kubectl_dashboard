import '../../../resources.dart';
import 'pod_spec.dart';

class Spec {
  static fromMap(Map<String, dynamic> data, {required ResourceKind kind}) {
    switch (kind) {
      case ResourceKind.pod:
        return PodSpec.fromMap(data);
      default:
        return PodSpec.fromMap(data);
    }
  }
}
