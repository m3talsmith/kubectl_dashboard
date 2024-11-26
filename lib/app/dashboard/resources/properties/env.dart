import 'field_ref.dart';

class Env {
  late String name;
  late FieldRef? valueFrom;

  Env.fromMap(Map<String, dynamic> data) {
    name = data['name'];
    if (data.containsKey('valueFrom')) {
      valueFrom = FieldRef.fromMap(data['valueFrom']);
    }
  }
}
