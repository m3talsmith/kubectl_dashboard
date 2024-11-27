import '../meta/object_meta.dart';
import 'persistent_volume_claim_spec.dart';

class PersistentVolumeClaimTemplate {
  late ObjectMeta metadata;
  late PersistentVolumeClaimSpec spec;

  PersistentVolumeClaimTemplate.fromMap(Map<String, dynamic> data) {
    metadata = ObjectMeta.fromMap(data['metadata']);
    spec = PersistentVolumeClaimSpec.fromMap(data['spec']);
  }
}
