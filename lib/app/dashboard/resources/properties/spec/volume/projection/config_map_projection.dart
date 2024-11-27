import 'package:kubectl_dashboard/app/dashboard/resources/properties/spec/key_to_path.dart';

class ConfigMapProjection {
  List<KeyToPath>? items;
  String? name;
  bool? optional;

  ConfigMapProjection.fromMap(Map<String, dynamic> data) {
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
