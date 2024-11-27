import '../object_field_selector.dart';
import '../resource_field_selector.dart';

class DownwardAPIVolumeFile {
  ObjectFieldSelector? fieldRef;
  int? mode;
  String? path;
  ResourceFieldSelector? resourceFieldRef;

  DownwardAPIVolumeFile.fromMap(Map<String, dynamic> data) {
    if (data['fieldRef'] != null) {
      fieldRef = ObjectFieldSelector.fromMap(data['fieldRef']);
    }
    mode = data['mode'];
    path = data['path'];
    if (data['resourceFieldRef'] != null) {
      resourceFieldRef =
          ResourceFieldSelector.fromMap(data['resourceFieldRef']);
    }
  }
}
