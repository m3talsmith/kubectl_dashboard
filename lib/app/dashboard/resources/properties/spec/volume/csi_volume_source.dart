import 'package:kubectl_dashboard/app/dashboard/resources/properties/spec/local_object_reference.dart';

class CSIVolumeSource {
  late String driver;
  late String fsType;
  late LocalObjectReference nodePublishSecretRef;
  late bool readOnly;
  late Map<String, dynamic> volumeAttributes;

  CSIVolumeSource.fromMap(Map<String, dynamic> data) {
    driver = data['driver'];
    fsType = data['fsType'];
    nodePublishSecretRef =
        LocalObjectReference.fromMap(data['nodePublishSecretRef']);
    readOnly = data['readOnly'];
    volumeAttributes = data['volumeAttributes'] as Map<String, dynamic>;
  }
}
