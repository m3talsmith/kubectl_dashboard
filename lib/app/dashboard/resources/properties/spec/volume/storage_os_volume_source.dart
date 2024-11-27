import 'package:kubectl_dashboard/app/dashboard/resources/properties/spec/local_object_reference.dart';

class StorageOSVolumeSource {
  late String fsType;
  late bool readOnly;
  late LocalObjectReference secretRef;
  late String volumeName;
  late String volumeNamespace;

  StorageOSVolumeSource.fromMap(Map<String, dynamic> data) {
    fsType = data['fsType'];
    readOnly = data['readOnly'];
    secretRef = LocalObjectReference.fromMap(data['secretRef']);
    volumeName = data['volumeName'];
    volumeNamespace = data['volumeNamespace'];
  }
}
