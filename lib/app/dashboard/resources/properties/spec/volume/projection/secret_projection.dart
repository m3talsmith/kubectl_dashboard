import 'package:kubectl_dashboard/app/dashboard/resources/properties/spec/key_to_path.dart';

class SecretProjection {
  late List<KeyToPath> items;
  late String name;
  late bool optional;

  SecretProjection.fromMap(Map<String, dynamic> data) {
    items = (data['items'] as List<Map<String, dynamic>>)
        .map(
          (e) => KeyToPath.fromMap(e),
        )
        .toList();
    name = data['name'];
    optional = data['optional'];
  }
}
