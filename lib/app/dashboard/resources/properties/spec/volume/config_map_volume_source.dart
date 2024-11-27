import '../key_to_path.dart';

class ConfigMapVolumeSource {
  int? defaultMode;
  List<KeyToPath>? items;
  String? name;
  bool? optional;

  ConfigMapVolumeSource.fromMap(Map<String, dynamic> data) {
    defaultMode = data['defaultMode'];
    if (data['items'] != null) {
      items = [];
      for (var e in data['items']) {
        items!.add(KeyToPath.fromMap(e));
      }
    }
    name = data['name'];
    optional = data['optional'];
  }
}
