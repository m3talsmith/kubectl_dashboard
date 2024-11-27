class VolumeDevice {
  late String devicePath;
  late String name;

  VolumeDevice.fromMap(Map<String, dynamic> data) {
    devicePath = data['devicePath'];
    name = data['name'];
  }
}
