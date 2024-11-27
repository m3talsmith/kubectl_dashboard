import '../key_to_path.dart';

class ConfigMapVolumeSource {
  late int defaultMode;
  late List<KeyToPath> items;
  late String name;
  late bool optional;

  ConfigMapVolumeSource.fromMap(Map<String, dynamic> data) {
    defaultMode = data['defaultMode'];
    items = (data['items'] as List<Map<String, dynamic>>)
        .map(
          (e) => KeyToPath.fromMap(e),
        )
        .toList();
    name = data['name'];
    optional = data['optional'];
  }
}
