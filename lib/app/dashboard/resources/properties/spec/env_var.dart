import 'env_var_source.dart';

class EnvVar {
  late String name;
  String? value;
  EnvVarSource? valueFrom;

  EnvVar.fromMap(Map<String, dynamic> data) {
    name = data['name'];
    value = data['value'];
    if (data['valueFrom'] != null) {
      valueFrom = EnvVarSource.fromMap(data['valueFrom']);
    }
  }
}
