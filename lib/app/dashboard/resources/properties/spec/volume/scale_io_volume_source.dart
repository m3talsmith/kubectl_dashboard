import 'package:kubectl_dashboard/app/dashboard/resources/properties/spec/local_object_reference.dart';

class ScaleIOVolumeSource {
  late String fsType;
  late String gateway;
  late String protectionDomain;
  late bool readOnly;
  late LocalObjectReference secretRef;
  late bool sslEnabled;
  late String storageMode;
  late String storagePool;
  late String system;
  late String volumeName;

  ScaleIOVolumeSource.fromMap(Map<String, dynamic> data) {
    fsType = data['fsType'];
    gateway = data['gateway'];
    protectionDomain = data['protectionDomain'];
    readOnly = data['readOnly'];
    secretRef = LocalObjectReference.fromMap(data['secretRef']);
    sslEnabled = data['sslEnabled'];
    storageMode = data['storageMode'];
    storagePool = data['storagePool'];
    system = data['system'];
    volumeName = data['volumeName'];
  }
}
