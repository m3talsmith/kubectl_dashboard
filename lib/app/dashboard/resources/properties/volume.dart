import 'config_map.dart';
import 'projected.dart';

class Volume {
  String? name;
  Projected? projected;
  ConfigMap? configMap;

  Volume.fromMap(Map<String, dynamic> data) {
    name = data['name'];

    if (data.containsKey('projected')) {
      projected = Projected.fromMap(data['projected']);
    }

    if (data.containsKey('configMap')) {
      configMap = ConfigMap.fromMap(data['configMap']);
    }
  }
}
