import 'package:kubectl_dashboard/app/dashboard/resources/properties/spec/local_object_reference.dart';

class FlexVolumeSource {
  late String driver;
  late String fsType;
  late Map<String, dynamic> options;
  late bool readOnly;
  late LocalObjectReference secretRef;

  FlexVolumeSource.fromMap(Map<String, dynamic> data) {
    driver = data['driver'];
    fsType = data['fsType'];
    options = {};
    for (var e in (data['options'] as Map<String, dynamic>).entries) {
      options[e.key] = e.value;
    }
    readOnly = data['readOnly'];
    secretRef = LocalObjectReference.fromMap(data['secretRef']);
  }
}
