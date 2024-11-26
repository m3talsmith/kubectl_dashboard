import 'metadata.dart';
import 'spec.dart';

class Template {
  late Metadata metadata;
  late Spec spec;

  Template.fromMap(Map<String, dynamic> data) {
    metadata = Metadata.fromMap(data['metadata']);
    spec = Spec.fromMap(data['spec']);
  }
}
