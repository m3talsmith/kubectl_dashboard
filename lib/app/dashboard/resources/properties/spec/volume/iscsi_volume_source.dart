import '../local_object_reference.dart';

class ISCSIVolumeSource {
  late bool chapAuthDiscovery;
  late bool chapAuthSession;
  late String fsType;
  late String initiatorName;
  late String iqn;
  late String iscsiInterface;
  late int lun;
  late List<String> portals;
  late bool readOnly;
  late LocalObjectReference secretRef;
  late String targetPortal;

  ISCSIVolumeSource.fromMap(Map<String, dynamic> data) {
    chapAuthDiscovery = data['chapAuthDiscovery'];
    chapAuthSession = data['chapAuthSession'];
    fsType = data['fsType'];
    initiatorName = data['initiatorName'];
    iqn = data['iqn'];
    iscsiInterface = data['iscsiInterface'];
    lun = data['lun'];
    portals = data['portals'] as List<String>;
    readOnly = data['readOnly'];
    secretRef = LocalObjectReference.fromMap(data['secretRef']);
    targetPortal = data['targetPortal'];
  }
}
