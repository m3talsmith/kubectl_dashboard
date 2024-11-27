import 'config_map_key_selector.dart';
import 'object_field_selector.dart';
import 'resource_field_selector.dart';
import 'secret_key_selector.dart';

class EnvVarSource {
  ConfigMapKeySelector? configMapKeyRef;
  ObjectFieldSelector? fieldRef;
  ResourceFieldSelector? resourceFieldRef;
  SecretKeySelector? secretKeyRef;

  EnvVarSource.fromMap(Map<String, dynamic> data) {
    if (data['configMapKeyRef'] != null) {
      configMapKeyRef = ConfigMapKeySelector.fromMap(data['configMapKeyRef']);
    }
    if (data['fieldRef'] != null) {
      fieldRef = ObjectFieldSelector.fromMap(data['fieldRef']);
    }
    if (data['resourceFieldRef'] != null) {
      resourceFieldRef =
          ResourceFieldSelector.fromMap(data['resourceFieldRef']);
    }
    if (data['secretKeyRef'] != null) {
      secretKeyRef = SecretKeySelector.fromMap(data['secretKeyRef']);
    }
  }
}
