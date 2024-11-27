import '../object_field_selector.dart';
import '../resource_field_selector.dart';

class DownwardAPIVolumeFile {
  late ObjectFieldSelector fieldRef;
  late int mode;
  late String path;
  late ResourceFieldSelector resourceFieldRef;

  DownwardAPIVolumeFile.fromMap(Map<String, dynamic> data) {
    fieldRef = ObjectFieldSelector.fromMap(data['fieldRef']);
    mode = data['mode'];
    path = data['path'];
    resourceFieldRef = ResourceFieldSelector.fromMap(data['resourceFieldRef']);
  }
}
