import 'package:kubectl_dashboard/app/dashboard/resources/properties/spec/local_object_reference.dart';

class CinderVolumeSource {
  late String fsType;
  late bool readOnly;
  late LocalObjectReference secretRef;
  late String volumeID;

  CinderVolumeSource.fromMap(Map<String, dynamic> data) {
    fsType = data['fsType'];
    readOnly = data['readOnly'];
    secretRef = LocalObjectReference.fromMap(data['secretRef']);
    volumeID = data['volumeID'];
  }
}
