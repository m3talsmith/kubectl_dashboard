import 'package:kubectl_dashboard/app/dashboard/resources/properties/spec/local_object_reference.dart';

class RBDVolumeSource {
  late String fsType;
  late String image;
  late String keyring;
  late List<String> monitors;
  late String pool;
  late bool readOnly;
  late LocalObjectReference secretRef;
  late String user;

  RBDVolumeSource.fromMap(Map<String, dynamic> data) {
    fsType = data['fsType'];
    image = data['image'];
    keyring = data['keyring'];
    monitors = data['monitors'] as List<String>;
    pool = data['pool'];
    readOnly = data['readOnly'];
    secretRef = LocalObjectReference.fromMap(data['secretRef']);
    user = data['user'];
  }
}
