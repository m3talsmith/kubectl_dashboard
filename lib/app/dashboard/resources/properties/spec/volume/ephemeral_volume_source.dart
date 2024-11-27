import '../persistent_volume_claim_template.dart';

class EphemeralVolumeSource {
  late PersistentVolumeClaimTemplate volumeClaimTemplate;

  EphemeralVolumeSource.fromMap(Map<String, dynamic> data) {
    volumeClaimTemplate =
        PersistentVolumeClaimTemplate.fromMap(data['volumeClaimTemplate']);
  }
}
