import 'package:kubectl_dashboard/app/dashboard/resources/properties/spec/key_to_path.dart';

class SecretVolumeSource {
  int? defaultMode;
  List<KeyToPath>? items;
  bool? optional;
  String? secretName;

  SecretVolumeSource.fromMap(Map<String, dynamic> data) {
    defaultMode = data['defaultMode'];
    if (data['items'] != null) {
      items = [];
      for (var e in data['items']) {
        items!.add(KeyToPath.fromMap(e));
      }
    }
    optional = data['optional'];
    secretName = data['secretName'];
  }
}
