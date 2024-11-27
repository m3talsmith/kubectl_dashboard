import 'package:kubectl_dashboard/app/dashboard/resources/properties/spec/key_to_path.dart';

class SecretVolumeSource {
  late int defaultMode;
  late List<KeyToPath> items;
  late bool optional;
  late String secretName;

  SecretVolumeSource.fromMap(Map<String, dynamic> data) {
    defaultMode = data['defaultMode'];
    items = (data['items'] as List<Map<String, dynamic>>)
        .map(
          (e) => KeyToPath.fromMap(e),
        )
        .toList();
    optional = data['optional'];
    secretName = data['secretName'];
  }
}
