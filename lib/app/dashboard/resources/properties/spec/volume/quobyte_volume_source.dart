class QuobyteVolumeSource {
  late String group;
  late bool readOnly;
  late String registry;
  late String tenant;
  late String user;
  late String volume;

  QuobyteVolumeSource.fromMap(Map<String, dynamic> data) {
    group = data['group'];
    readOnly = data['readOnly'];
    registry = data['registry'];
    tenant = data['tenant'];
    user = data['user'];
    volume = data['volume'];
  }
}
