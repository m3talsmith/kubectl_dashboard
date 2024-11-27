import 'env_var_source.dart';

class EnvVar {
  late String name;
  late String value;
  late EnvVarSource valueFrom;

  EnvVar.fromMap(Map<String, dynamic> data) {
    name = data['name'];
    value = data['value'];
    valueFrom = EnvVarSource.fromMap(data['valueFrom']);
  }
}
