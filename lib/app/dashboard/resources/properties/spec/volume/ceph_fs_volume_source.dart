import '../local_object_reference.dart';

class CephFSVolumeSource {
  late List<String> monitors;
  late String path;
  late bool readOnly;
  late String secretFile;
  late LocalObjectReference secretRef;
  late String user;

  CephFSVolumeSource.fromMap(Map<String, dynamic> data) {
    monitors = data['monitors'] as List<String>;
    path = data['path'];
    readOnly = data['readOnly'];
    secretFile = data['secretFile'];
    secretRef = LocalObjectReference.fromMap(data['secretRef']);
    user = data['user'];
  }
}
