import 'config_map_key_selector.dart';
import 'object_field_selector.dart';
import 'resource_field_selector.dart';
import 'secret_key_selector.dart';

class EnvVarSource {
  late ConfigMapKeySelector configMapKeyRef;
  late ObjectFieldSelector fieldRef;
  late ResourceFieldSelector resourceFieldRef;
  late SecretKeySelector secretKeyRef;

  EnvVarSource.fromMap(Map<String, dynamic> data) {
    configMapKeyRef = ConfigMapKeySelector.fromMap(data['configMapKeyRef']);
    fieldRef = ObjectFieldSelector.fromMap(data['fieldRef']);
    resourceFieldRef = ResourceFieldSelector.fromMap(data['resourceFieldRef']);
    secretKeyRef = SecretKeySelector.fromMap(data['secretKeyRef']);
  }
}
