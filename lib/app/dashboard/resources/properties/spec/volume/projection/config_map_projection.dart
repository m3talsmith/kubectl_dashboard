import 'package:kubectl_dashboard/app/dashboard/resources/properties/spec/key_to_path.dart';

class ConfigMapProjection {
  late List<KeyToPath> items;
  late String name;
  late bool optional;

  ConfigMapProjection.fromMap(Map<String, dynamic> data) {
    items = (data['items'] as List<Map<String, dynamic>>)
        .map(
          (e) => KeyToPath.fromMap(e),
        )
        .toList();
    name = data['name'];
    optional = data['optional'];
  }
}
